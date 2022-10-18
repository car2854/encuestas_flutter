import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  
  final String title;
  final Function() onPressed;
  final Color primaryColor;
  final Color textColor;
  
  const ButtonWidget({
    Key? key, 
    required this.title, 
    required this.onPressed, 
    this.primaryColor = Colors.blue, 
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        
        
      ),
      child: Text(title, style: TextStyle(color: textColor),),
    );
  }
}