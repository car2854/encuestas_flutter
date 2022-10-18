import 'package:bloc/bloc.dart';
import 'package:encuesta_flutter/models/models.dart';
import 'package:encuesta_flutter/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final storage = const FlutterSecureStorage();

  final AuthService authService = AuthService();
  User? user;
  ErrorResponse? error;

  UserBloc() : super(const UserState()) {

    // Definir email
    // on<OnSendEmail>((event, emit) {
    //   emit(state.copyWith(email: event.email));
    // });

    // on<OnSendPassword>((event, emit) {
    //   emit(state.copyWith(password: event.password));
    // });

  }

  Future login(String email, String password)async{

    final Response resp = await authService.login(email, password);

    if (resp.statusCode == 200){

      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await storage.write(key: 'token', value: loginResponse.token);

      return true;


    }else{

      error = errorResponseFromJson(resp.body);

      return false;
    }
  }

  Future register(String email, String password, String name) async{

    final Response resp = await authService.register(email, password, name);

    if (resp.statusCode == 200){

      final registerResponse = registerResponseFromJson(resp.body);
      user = registerResponse.user;
      await storage.write(key: 'token', value: registerResponse.token);
      
      return true;
    }else{

      error = errorResponseFromJson(resp.body);
      print(resp.body);
      
      return false;
    }

  }

  Future<bool> renewToken() async{

    final token = await storage.read(key: 'token') ?? '';

    final Response resp = await authService.renewToken(token);

    if (resp.statusCode == 200){

      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await storage.write(key: 'token', value: loginResponse.token);

      return true;
    }else{

      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }

  }

  Future logout() async{
    await storage.delete(key: 'token');
  }
}
