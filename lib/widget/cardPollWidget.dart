import 'package:encuesta_flutter/theme/theme.dart';
import 'package:flutter/material.dart';

class CardPollWidget extends StatelessWidget {

  final String category;
  final String userName;
  final String question;
  final List<Widget> children;
  final String initDate;
  final String endDate;
  final bool isChecked;

  const CardPollWidget({
    Key? key, 
    required this.category, 
    this.userName = '', 
    required this.question, 
    required this.children, 
    required this.initDate, 
    required this.endDate, 
    this.isChecked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                title: Text(category, style: TextStyle(color: ColorTheme.colorPrimary, fontWeight: FontWeight.bold),),
                subtitle: (userName.trim().isNotEmpty) ? Text(userName) : null,
                trailing: (isChecked)? Icon(Icons.check, color: ColorTheme.colorPrimary,) : null
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(question, style: const TextStyle(fontSize: 14),)
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text('Fecha inicio: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                    Text(initDate, style: const TextStyle(fontSize: 13),)
                  ],
                )
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text('Fecha fin: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(endDate, style: const TextStyle(fontSize: 13),),
                  ],
                )
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }
}