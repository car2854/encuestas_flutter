import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedirectPages extends StatelessWidget {
  const RedirectPages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<bool>(
          future: _verifyToken(context),
          builder: (context, snapshot){

            return const SizedBox();
          },
        )
      )
    );
  }

  Future<bool> _verifyToken(context)async{

    final userBloc = BlocProvider.of<UserBloc>(context);

    final navigator = Navigator.of(context);
    final bool status = await userBloc.renewToken();

    if (status){
      navigator.pushNamedAndRemoveUntil('mainPage', (route) => false);
    }else{
      navigator.pushNamedAndRemoveUntil('login', (route) => false);
    }

    return status;

  }
}