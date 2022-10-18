import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class MyPollWidget extends StatelessWidget {
  const MyPollWidget({
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
              FutureBuilder<bool>(
                future: pollBloc.getMyPolls(),
                builder: (context, snapshot) {

                  if (snapshot.hasData){
                    return BlocBuilder<PollBloc, PollState>(
                      builder: (context, state) {
                        if (state.myPolls != null && state.myPolls!.isNotEmpty){
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.myPolls!.length,
                            itemBuilder: (context, index) {
                              return CardPollWidget(
                                category: state.myPolls![index].category.name,
                                question: state.myPolls![index].description,
                                initDate: DateFormat('yyyy-MM-dd').format(state.myPolls![index].initPoll),
                                endDate: DateFormat('yyyy-MM-dd').format(state.myPolls![index].endPoll),
                                children: [

                                  (!state.myPolls![index].isActive)
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        child: TextButton(
                                          child: Text('Activar'.toUpperCase(), style: TextStyle(color: ColorTheme.colorPrimary),),
                                          onPressed: () {

                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: const Text('Activar esta encuesta'),
                                                content: const Text('Una ves activado, no se podra agregar mas opciones, estas seguro?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () async{
                                                      
                                                      final navigator = Navigator.of(context);

                                                      final status = await pollBloc.activatedPoll(state.myPolls![index].id);

                                                      if (!status){
                                                        if (pollBloc.error != null){
                                                          EasyLoading.showToast(pollBloc.error!.msg, toastPosition: EasyLoadingToastPosition.bottom, duration: const Duration(seconds: 1));
                                                        }
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
                                        ),
                                      )
                                    : const SizedBox(),


                                  (!state.myPolls![index].isActive)
                                    ? TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero
                                      ),
                                      child: Text('Opciones'.toUpperCase(), style: TextStyle(color: ColorTheme.colorPrimary),),
                                      onPressed: () {
                                        pollBloc.add(OnSelectPoll(state.myPolls![index]));
                                        Navigator.pushNamed(context, 'addOptions');
                                      },
                                    ) 
                                    : TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero
                                      ),
                                      child: Text('Detalle'.toUpperCase(), style: TextStyle(color: ColorTheme.colorPrimary),),
                                      onPressed: () {
                                        pollBloc.add(OnSelectPoll(state.myPolls![index]));
                                        Navigator.pushNamed(context, 'detailPoll');
                                      },
                                    ),


                                ],
                              );
                            },
                          );
                        }else{
                          return const Center(child: Text('ok'),);
                        }
                      },
                    );
                  }else{
                    return const Center(child: Text('ok'),);
                  }
                },
              ),
              FloatingButtonDownWidget(
                icon: const Icon(Icons.add, size: 30,),
                onPressed: (){
                  Navigator.pushNamed(context, 'newPoll');
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

