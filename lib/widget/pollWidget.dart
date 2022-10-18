import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/models/models/participate.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class PollWidget extends StatelessWidget {
  const PollWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pollBloc = BlocProvider.of<PollBloc>(context);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: FutureBuilder(
                  future: pollBloc.getPublicPolls(),
                  builder: (context, snapshot){
                    if (snapshot.hasData){

                      return BlocBuilder<PollBloc, PollState>(
                        builder: (context, state) {

                          if (state.publicPolls != null && state.publicPolls!.isNotEmpty){
                            // return const Center(child: Text('Data'),);
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.publicPolls!.length,
                              itemBuilder: (context, index){
                                return CardPollWidget(
                                  isChecked: verifyCheked(context, state.publicPolls![index].participates),
                                  category: state.publicPolls![index].category.name,
                                  question: state.publicPolls![index].description,
                                  userName: state.publicPolls![index].user.name,
                                  initDate: DateFormat('yyyy-MM-dd').format(state.publicPolls![index].initPoll),
                                  endDate: DateFormat('yyyy-MM-dd').format(state.publicPolls![index].endPoll),
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero
                                      ),
                                      onPressed: () {
                                        
                                        pollBloc.add(OnSelectPoll(state.publicPolls![index]));
                                        _showPublicOption(context);

                                      },
                                      child: Text('Participar'.toUpperCase(), style: TextStyle(color: ColorTheme.colorPrimary),),
                                    ),
                                  ],
                                );
                              },
                            );

                          }else{
                            return const Center(child: Text('No existen encuestas'),);
                          }
                        },
                      );
                    }else{
                      return const Center(child: Text('Data'),);
                    }
                  },
                ) 

              )
            ],
          ),
        )
      ]
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
                      return (optionBloc.participate==null)
                        ? TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(state.options![index].name)),
                                Text(state.options![index].amountVote.toString())
                              ],
                            ),
                            onPressed: () async{

                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Estas seguro'),
                                  content: const Text('Una ves escogido esta opcion, no hay vuelta atras'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async{
                                        
                                        final navigator = Navigator.of(context);
                                        final state = await optionBloc.voteOption(optionBloc.state.options![index].id, pollBloc.state.selectPoll!.id);
                                        if (state){
                                          navigator.pop();



                                        }else{
                                          if (optionBloc.error!= null) EasyLoading.showToast(optionBloc.error!.msg, toastPosition: EasyLoadingToastPosition.bottom, duration: const Duration(seconds: 1));
                                        }
                                        navigator.pop();

                                      },
                                      child: const Text('Si'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                ),
                              );

                            }, 
                          )
                        : Container(
                          decoration: BoxDecoration(

                            color: (optionBloc.participate!.optionId == state.options![index].id) ? Colors.blue : Colors.white
                          
                          ),
                          child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(
                                    state.options![index].name, style: TextStyle(color: (optionBloc.participate!.optionId == state.options![index].id)? Colors.white: Colors.blue),
                                  )),
                                  Text(state.options![index].amountVote.toString(), style: TextStyle(color: (optionBloc.participate!.optionId == state.options![index].id)? Colors.white: Colors.blue),)
                                ],
                              ),
                              onPressed: () async{
                                final navigator = Navigator.of(context);
                                final state = await optionBloc.voteOption(optionBloc.state.options![index].id, pollBloc.state.selectPoll!.id);
                                if (state){
                                  navigator.pop();
                                }else{
                                  if (optionBloc.error != null){
                                    EasyLoading.showToast(optionBloc.error!.msg, toastPosition: EasyLoadingToastPosition.bottom, duration: const Duration(seconds: 1));
                                  }
                                  // TODO: Error
                                }
                              }, 
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

  bool verifyCheked(context, List<Participate>? participates){
    if (participates == null) return false;
    final userBloc = BlocProvider.of<UserBloc>(context);

    bool exist = false;
    for (var participate in participates) {
      
      if (participate.userId == userBloc.user!.id) exist = true;

    }

    return exist;
  }
}
