import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {

  final Icon icon;
  final Function() onPressed;

  const IconButtonWidget({
    Key? key, 
    required this.icon, 
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: icon
    );
  }
}