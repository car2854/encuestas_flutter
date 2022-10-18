import 'package:encuesta_flutter/global/enviroment.dart';
import 'package:http/http.dart' as http;

class CategoryService{

  Future getCategories() async{

    final urlParse = Uri.parse('${Enviroment.apiUrl}/category');
    final resp = await http.get(urlParse, 
      headers: {
        'Content-Type': 'application/json'
      }
    );

    return resp;

  }  

}

