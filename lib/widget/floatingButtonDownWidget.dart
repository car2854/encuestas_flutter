import 'package:encuesta_flutter/theme/theme.dart';
import 'package:flutter/material.dart';

class FloatingButtonDownWidget extends StatelessWidget {

  final Icon icon;
  final Function() onPressed;

  const FloatingButtonDownWidget({
    Key? key, 
    required this.icon, 
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11, right: 11),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: ColorTheme.colorPrimary,
          onPressed: onPressed,
          child: icon
        ),
      ),
    );
  }
}