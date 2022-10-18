import 'package:encuesta_flutter/models/models/option.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MapChat{

  List<PieChartSectionData> parseMapChat(List<Option> options){

    List<PieChartSectionData>list = [];

    var i = 0;
    for (var option in options) {
      
      final PieChartSectionData data = PieChartSectionData(
        value: option.amountVote.toDouble(),
        color: ColorTheme.colorChart[i].background,
        radius: 40,
        showTitle: true,
        titleStyle: TextStyle(color: ColorTheme.colorChart[i].text, fontSize: 16, fontWeight: FontWeight.bold),
        badgeWidget: Text(option.id.toString(), style: const TextStyle(color: Color.fromARGB(0, 255, 255, 255)),),
        title: option.amountVote.toString(),
        borderSide: const BorderSide(width: 0),
        titlePositionPercentageOffset: 0.5,
        badgePositionPercentageOffset: 0.5
      );

      list.add(data);
      i++;

    }

    return list;
    
  }

}