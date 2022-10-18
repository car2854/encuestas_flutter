import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/cardPollWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class VotedPollWidget extends StatelessWidget {
  const VotedPollWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pollBloc = BlocProvider.of<PollBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<bool>(
          future: pollBloc.getVotedPolls(),
          builder: (context, snapshot) {
            
            if (snapshot.hasData){

              return BlocBuilder<PollBloc, PollState>(
                builder: (context, state) {
                  
                  if (state.votedPolls==null || state.votedPolls!.isEmpty){
                    return const Center(child: Text('No hay datos'),);
                  }else{
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.votedPolls!.length,
                      itemBuilder: (context, index){
                        return CardPollWidget(
                          category: state.votedPolls![index].category.name,
                          question: state.votedPolls![index].description,
                          userName: state.votedPolls![index].user.name,
                          initDate: DateFormat('yyyy-MM-dd').format(state.votedPolls![index].initPoll),
                          endDate: DateFormat('yyyy-MM-dd').format(state.votedPolls![index].endPoll),
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero
                              ),
                              onPressed: () {
                                
                                pollBloc.add(OnSelectPoll(state.votedPolls![index]));
                                _showPublicOption(context);

                              },
                              child: Text('Participar'.toUpperCase(), style: TextStyle(color: ColorTheme.colorPrimary),),
                            ),
                          ],
                        );
                      },
                    );
                  }

                },
              );

            }else{
              return const Center(child: Text('Cargando'),);
            }

          },
        )
      )
    );
  }

  Future<dynamic> _showPublicOption(BuildContext context) {

    final optionBloc = BlocProvider.of<OptionBloc>(context);
    final pollBloc = BlocProvider.of<PollBloc>(context);

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: optionBloc.getPublicOptions(pollBloc.state.selectPoll!.id),
          builder: (context, snapshot) {
            
            if (snapshot.hasData){
              
              if (snapshot.data == true){
                return BlocBuilder<OptionBloc, OptionState>(
                  builder: (context, state) {
                    
                    return ListView.builder(
                    itemCount: optionBloc.state.options!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(

                            color: (optionBloc.participate!.optionId == state.options![index].id) ? Colors.blue : Colors.white
                          
                          ),
                          child: TextButton(
                              onPressed: null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(
                                    state.options![index].name, style: TextStyle(color: (optionBloc.participate!.optionId == state.options![index].id)? Colors.white: Colors.blue),
                                  )),
                                  Text(state.options![index].amountVote.toString(), style: TextStyle(color: (optionBloc.participate!.optionId == state.options![index].id)? Colors.white: Colors.blue),)
                                ],
                              ) 
                            ),
                        );

                    });

                  },
                );
              }else{
                return const Center(child: Text('Error'),);
              }

            }else{
              return const Center(child: Text('Loading'),);
            }

          },
        );
      },
    );
  }
}