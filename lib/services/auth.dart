import 'dart:convert';

import 'package:encuesta_flutter/global/enviroment.dart';
import 'package:http/http.dart' as http;


class AuthService{

  Future login(String email, String password) async{
    
    final data = {
      'email': email,
      'password': password
    };

    var urlParse = Uri.parse('${Enviroment.apiUrl}/auth/login');
    final resp = await http.post(urlParse, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    return resp;
  }

  Future register(String email, String password, String name) async{

    final data = {
      'email': email,
      'password': password,
      'name': name
    };

    var urlParse = Uri.parse('${Enviroment.apiUrl}/user');

    final resp = await http.post(urlParse,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      } 
    );

    return resp;
  }

  Future renewToken(String token) async{

    var urlParse = Uri.parse('${Enviroment.apiUrl}/auth/renew');

    final resp = await http.post(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    return resp;
  }

}