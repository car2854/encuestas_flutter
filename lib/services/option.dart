import 'dart:convert';

import 'package:encuesta_flutter/global/enviroment.dart';
import 'package:http/http.dart' as http;

class OptionService{

  Future getOptions(int id, String token)async{
    final urlParse = Uri.parse('${Enviroment.apiUrl}/option/$id');
    final resp = await http.get(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
  }
 
  Future getPublicOptions(int id, String token)async{
    final urlParse = Uri.parse('${Enviroment.apiUrl}/option/public/$id');
    final resp = await http.get(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
  }

  Future addOption(String name, int id, String token)async{

    final data = {
      'name': name,
      'poll_id': id
    };

    final urlParse = Uri.parse('${Enviroment.apiUrl}/option');

    final resp = await http.post(urlParse, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    return resp;
  }

  Future deleteOption(int id, String token)async {

    final urlParse = Uri.parse('${Enviroment.apiUrl}/option/$id');
    final resp = await http.delete(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
    
  }

  Future newVoteOption(int id, String token)async {

    final urlParse = Uri.parse('${Enviroment.apiUrl}/option/add/$id');
    final resp = await http.put(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
    
  }

  Future getDetailsOptionComplete(int id, String token) async{
    
    final urlParse = Uri.parse('${Enviroment.apiUrl}/option/getDetailsOptionComplete/$id');
    final resp = await http.get(urlParse, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;

  }

}