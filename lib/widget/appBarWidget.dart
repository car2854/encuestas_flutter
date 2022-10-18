import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/global/enviroment.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return AppBar(
      actions: [
        IconButtonWidget(
          icon: const Icon(Icons.logout),
          onPressed: () =>

            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Cerrar sesion'),
                content: const Text('Estas seguro que quieres cerrar sesion?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async{
                      
                      final navigator = Navigator.of(context);
                      await userBloc.logout();
                      navigator.pushNamedAndRemoveUntil('login', (route) => false);

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
            )
            
        )
      ],
      backgroundColor: ColorTheme.colorPrimary,
      flexibleSpace: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(userBloc.user!.name, style: const TextStyle(color: Colors.white),)
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(Enviroment.nameApp.toUpperCase(), style: const TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }
}

