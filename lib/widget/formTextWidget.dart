import 'dart:ffi';

import 'package:flutter/material.dart';

class FormTextWidget extends StatelessWidget {

  final String title;
  final Icon icon;
  final bool obscureText;
  final bool isIcon;
  final int maxLine;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function()? onTap;

  const FormTextWidget({
    Key? key, 
    this.obscureText = false, 
    this.isIcon = false,
    this.maxLine = 1,
    this.keyboardType = TextInputType.text,
    this.onTap,
    required this.title, 
    required this.icon, 
    required this.controller, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        icon: (isIcon)? icon: null,
        labelText: title,
        alignLabelWithHint: true
        
      ),
      obscureText: obscureText,
      maxLines: maxLine,
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,

    );
  }
}