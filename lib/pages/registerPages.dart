import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({ Key? key }) : super(key: key);

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: ColorTheme.colorPrimary,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Registro'.toUpperCase(), style: TextStyle(fontSize: 18, color: ColorTheme.colorPrimary),),
                  FormTextWidget(
                    title: 'Nombre de usuario',
                    isIcon: true,
                    icon: const Icon(Icons.person_sharp),
                    controller: userNameController,
                  ),
                  FormTextWidget(
                    title: 'Email',
                    isIcon: true,
                    icon: const Icon(Icons.email),
                    controller: emailNameController,
                  ),
                  FormTextWidget(
                    title: 'Password',
                    isIcon: true,
                    icon: const Icon(Icons.key),
                    obscureText: true,
                    controller: passwordNameController,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  ButtonWidget(
                    title: 'Registrar',
                    onPressed: ()async{

                      if ( emailNameController.text.trim().isNotEmpty && passwordNameController.text.trim().isNotEmpty && userNameController.text.trim().isNotEmpty){
                        
                        final navigator = Navigator.of(context);
                        final status = await userBloc.register(emailNameController.value.text, passwordNameController.value.text, userNameController.value.text);
                        if (status){
                          navigator.pushNamedAndRemoveUntil('mainPage', (route) => false);
                        }else{
                          // TODO: Error aqui, mostrar el mensaje de error mandado desde el backend, ya existe un modelo de error en el bloc
                          if (userBloc.error != null){
                            EasyLoading.showError(userBloc.error!.msg, duration: const Duration(seconds: 3));
                          }
                        }

                      }
                    },
                  ),
                  ButtonWidget(
                    title: 'Ya tienes una cuenta, ingresa sesion aqui',
                    primaryColor: const Color.fromARGB(0, 255, 255, 255),
                    textColor: ColorTheme.colorPrimary,
                    onPressed: (){
                      Navigator.pushNamed(context, 'login');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}