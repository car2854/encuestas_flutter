import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPages extends StatefulWidget {  
  
  const LoginPages({ Key? key }) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  Text('Login'.toUpperCase(), style: TextStyle(fontSize: 18, color: ColorTheme.colorPrimary),),
                  FormTextWidget(
                    title: 'Email',
                    icon: const Icon(Icons.email),
                    isIcon: true,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  FormTextWidget(
                    title: 'Password',
                    icon: const Icon(Icons.key),
                    isIcon: true,
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  ButtonWidget(
                    title: 'Login',
                    onPressed: ()async{


                      if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty){
                        
                        final navigator = Navigator.of(context);
                        final status = await userBloc.login(emailController.value.text, passwordController.value.text);

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
                    title: 'No tienes una cuenta, registrate aqui',
                    primaryColor: const Color.fromARGB(0, 255, 255, 255),
                    textColor: ColorTheme.colorPrimary,
                    onPressed: () { 
                      Navigator.pushNamed(context, 'register');
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