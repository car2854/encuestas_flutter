import 'package:encuesta_flutter/theme/theme.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  
  final String name;
  
  const CategoryWidget({
    Key? key, 
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ColorTheme.colorPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name, style: const TextStyle(color: Colors.white),)
        ),
      ),
    );
  }
}