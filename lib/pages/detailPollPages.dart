import 'dart:convert';

import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/helpers/mapChart.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/appBarWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailPollPage extends StatelessWidget {
  const DetailPollPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pollBloc = BlocProvider.of<PollBloc>(context);
    final optionBloc = BlocProvider.of<OptionBloc>(context);

    final MapChat mapChat = MapChat();


    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(125),
          child: AppBarWidget(),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Text(pollBloc.state.selectPoll!.category.name, style: TextStyle(color: ColorTheme.colorPrimary, fontSize: 19),),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    Text(pollBloc.state.selectPoll!.description),
                    const Padding(padding: EdgeInsets.only(bottom: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fecha inicio: ${DateFormat('yyyy-MM-dd').format(pollBloc.state.selectPoll!.initPoll)}', style: const TextStyle(fontSize: 13),),
                        Text('Fecha fin: ${DateFormat('yyyy-MM-dd').format(pollBloc.state.selectPoll!.endPoll)}', style: const TextStyle(fontSize: 13),),
                      ],
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: optionBloc.getOptions(pollBloc.state.selectPoll!.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return Expanded(
                      child: Column(
                        children: [


                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback: (p0, p1) {

                                      if (p1 != null){
                                        if (p1.touchedSection!.touchedSection != null){
                                          String data = p1.touchedSection!.touchedSection!.badgeWidget.toString();
                                          String newData = '';
                            
                                          bool isEnd = false;
                                          for (var i = 0; i < data.length && !isEnd; i++) {
                                            if (data[i] == ','){
                                              isEnd = true;
                                            }
                                            newData = newData + data[i];
                                          }
                            
                                          String idOptionString = newData.replaceAll(RegExp(r'[^0-9]'),'');
                                          int idOption = int.parse(idOptionString);
                                          
                            
                                          _detailsOptionSelected(context, idOption);
                                        }
                            
                                      }



                                    },
                                  ),
                                  sections: mapChat.parseMapChat(optionBloc.state.options!)                                
                                ),
                                swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                                swapAnimationCurve: Curves.linear, // 
                              ),
                            )
                          ),


                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.only(top: 5),
                              child: ListView.builder(
                                itemCount: optionBloc.state.options!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(right: 6),
                                          width: 20,
                                          height: 20,
                                          color: ColorTheme.colorChart[index].background,
                                        ),
                                        Expanded(child: Text(optionBloc.state.options![index].name)),
                                        Text(optionBloc.state.options![index].amountVote.toString()),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          


                        ],
                      ),
                    );
                  }else{
                    return const Center(child: Text('Cargando'),);
                  }
                },
              ),
     
            ],
          ),
        ),
      )
    );
  }

  Future<dynamic> _detailsOptionSelected(BuildContext context, int id) {

    final optionBloc = BlocProvider.of<OptionBloc>(context);

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<bool>(
          future: optionBloc.getDetailsOptionComplete(id),
          builder: (context, snapshot) {
            
            if (snapshot.hasData){
              
              if (optionBloc.detailOptions != null){

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(optionBloc.detailOptions!.name)),
                          Text(optionBloc.detailOptions!.amountVote.toString()),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text('Usuarios que eligieron esta opcion', style: TextStyle(color: ColorTheme.colorPrimary),),
                      const SizedBox(height: 5,),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: optionBloc.detailOptions!.participates.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(optionBloc.detailOptions!.participates[index].user.name)
                            );  
                          },
                        ),
                      ),
                    ],
                  ),
                );

              }else{
                return const Center(child: Text('No hay nada que mostrar'),);
              }

            }else{
              return const Center(child: Text('Cargando'),);
            }

          },
        );
      },
    );
  }
}