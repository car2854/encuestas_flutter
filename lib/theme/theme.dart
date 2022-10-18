import 'package:encuesta_flutter/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorTheme{
  static Color colorPrimary = Colors.blue;


  static List<StyleColorChart> colorChart = [
    StyleColorChart(background: Colors.red, text: Colors.white),
    StyleColorChart(background: Colors.blue, text: Colors.white),
    StyleColorChart(background: Colors.green, text: Colors.white),
    StyleColorChart(background: Colors.black, text: Colors.white),
    StyleColorChart(background: Colors.white, text: Colors.black),
    StyleColorChart(background: Colors.yellow, text: Colors.black),
    StyleColorChart(background: Colors.cyan, text: Colors.black),
    StyleColorChart(background: Colors.orange, text: Colors.white),
  ];
}