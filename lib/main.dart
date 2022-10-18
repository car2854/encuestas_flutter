import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(

    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (context) => PollBloc(userBloc: BlocProvider.of<UserBloc>(context))),
        BlocProvider(create: (context) => OptionBloc(userBloc: BlocProvider.of<UserBloc>(context), pollBloc: BlocProvider.of<PollBloc>(context))),
      ],
      child: const MyApp(),
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: 'redirect',
      routes: {
        'login'           : (_) => const LoginPages(),
        'register'        : (_) => const RegisterPages(),
        'mainPage'        : (_) => const MainPages(),
        'newPoll'         : (_) => const NewPollPages(),
        'category'        : (_) => const CategoyPages(),
        'redirect'        : (_) => const RedirectPages(),
        'addOptions'      : (_) => const AddOptionsPages(),
        'detailPoll'      : (_) => const DetailPollPage(),
      },
    );
  }
}

