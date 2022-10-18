import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/appBarWidget.dart';
import 'package:encuesta_flutter/widget/buttonWidget.dart';
import 'package:encuesta_flutter/widget/formTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class AddOptionsPages extends StatefulWidget {
  const AddOptionsPages({ Key? key }) : super(key: key);

  @override
  State<AddOptionsPages> createState() => _AddOptionsPagesState();
}

class _AddOptionsPagesState extends State<AddOptionsPages> {

  final TextEditingController optionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final pollBloc = BlocProvider.of<PollBloc>(context);
    final optionBloc = BlocProvider.of<OptionBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(125),
          child: AppBarWidget(),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
        
              BlocBuilder<PollBloc, PollState>(
                builder: (context, state) => Column(
                  children: [
                    const SizedBox(height: 15,),
                    Text(state.selectPoll!.category.name, style: TextStyle(color: ColorTheme.colorPrimary, fontSize: 20),),
                    const SizedBox(height: 15,),
                    Text(state.selectPoll!.description),
                    const SizedBox(height: 15,),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('Creado: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(DateFormat('yyyy-MM-dd').format(state.selectPoll!.createdAt)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('Inicia: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(DateFormat('yyyy-MM-dd').format(state.selectPoll!.initPoll)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Termina: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(DateFormat('yyyy-MM-dd').format(state.selectPoll!.endPoll)),
                              ],
                            ),
                          ],
                        ),
                      ],
                      
                    ),
        
                  ],
                ),
              ),
        
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    FormTextWidget(
                      controller: optionController,
                      icon: const Icon(Icons.question_mark),
                      title: 'Opcion',
                      isIcon: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ButtonWidget(
                        title: 'Agregar', 
                        primaryColor: ColorTheme.colorPrimary, 
                        textColor: Colors.white,
                        onPressed: () async{
                          
                          if (optionController.text.trim().isNotEmpty){
                            final status = await optionBloc.addOption(optionController.value.text, pollBloc.state.selectPoll!.id);
                            if (status){
                              optionController.text = '';
                            }else{
                              if (optionBloc.error != null) EasyLoading.showToast(optionBloc.error!.msg, toastPosition: EasyLoadingToastPosition.top, duration: const Duration(seconds: 1));
                              
                              
                            }
                          }
                        
                        }, 
                      ),
                    ),
                  ],
                ),
              ),
        
        
              FutureBuilder(
                future: optionBloc.getOptions(pollBloc.state.selectPoll!.id),
                builder: (context, snapshot) {
                  
                  return BlocBuilder<OptionBloc, OptionState>(
                    builder: (context, state) {
        
                      if (state.options == null || state.options!.isEmpty){
        
                        return const Center(child: Text('No existe ninguna opcion disponible'),);
        
                      }else{
        
                        return Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.options!.length,
                            itemBuilder: (context, index) {
        
                              return Container(
                                padding: const EdgeInsets.only(top: 8, right: 5, left: 5, bottom: 4),
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0x802195F3)),
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8))
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(state.options![index].name)
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ButtonWidget(
                                          title: 'Eliminar', 
                                          primaryColor: ColorTheme.colorPrimary, 
                                          textColor: Colors.white,
                                          onPressed: ()async{


                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: const Text('Eliminar'),
                                                content: const Text('Estas seguro que quieres eliminar esta opcion?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () async{
                                                      
                                                      optionBloc.deleteOption(state.options![index].id);
                                                      Navigator.pop(context);

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
                                      ],
                                    )
                                  ],
                                ),
                              );
        
                            },
                          ),
                        );
        
                      }
                    },
                  );
                  
        
                },
              ),
        
              BlocBuilder<OptionBloc, OptionState>(
                builder: (context, state) {
                  return (state.options != null && state.options!.length >= 2) 
                    ? ButtonWidget(
                      title: 'Activar', 

                      onPressed: (){
        
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Activar esta encuesta'),
                            content: const Text('Una ves activado, no se podra agregar mas opciones, estas seguro?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async{
                                  
                                  final navigator = Navigator.of(context);
        
                                  final status = await pollBloc.activatedPoll(pollBloc.state.selectPoll!.id);
        
                                  if (!status){
                                    if (pollBloc.error != null){
                                      EasyLoading.showToast(pollBloc.error!.msg, toastPosition: EasyLoadingToastPosition.bottom, duration: const Duration(seconds: 1));
                                    }
                                  }else{
                                    navigator.pop();
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
                    : Container();
                },
              ),
              
            ],
          ),
        ),
      )
    );
  }
}