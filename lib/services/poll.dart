import 'dart:convert';

import 'package:encuesta_flutter/global/enviroment.dart';
import 'package:http/http.dart' as http;

class PollService {

  Future getVotedPolls(String token) async{
    final urlParse = Uri.parse('${Enviroment.apiUrl}/poll/getVotedPolls');

    final resp = await http.get(urlParse,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
  }
  
  Future getPublicPolls(String token) async{
    final urlParse = Uri.parse('${Enviroment.apiUrl}/poll/public');

    final resp = await http.get(urlParse,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
  }

  Future getMyPolls(String token) async{

    final urlParse = Uri.parse('${Enviroment.apiUrl}/poll');

    final resp = await http.get(urlParse, 
    headers: {
      'Content-Type': 'application/json',
      'x-token': token
    });

    return resp;

  }

  Future createPoll(String description, DateTime initPoll, DateTime endPoll, int categoryId, String token)async{

    final data = {
      'description': description,
      'init_poll': initPoll.toIso8601String(),
      'end_poll': endPoll.toIso8601String(),
      'category_id': categoryId,
    };

    final urlParse = Uri.parse('${Enviroment.apiUrl}/poll');

    final resp = await http.post(urlParse,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    return resp;

  }

  Future activatedPoll(int id, String token) async{
    final urlParse = Uri.parse('${Enviroment.apiUrl}/poll/activate/$id');
    final resp = await http.put(urlParse,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    return resp;
  }

}