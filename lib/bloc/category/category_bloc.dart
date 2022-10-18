import 'package:bloc/bloc.dart';
import 'package:encuesta_flutter/models/models.dart';
import 'package:encuesta_flutter/services/services.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final CategoryService categoryService = CategoryService();
  List<Category>? categories;
  ErrorResponse? error;

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<bool> getCategories() async{

    final Response resp = await categoryService.getCategories();

    if (resp.statusCode == 200){

      final categoryResponse = categoryResponseFromJson(resp.body);
      categories = categoryResponse.categories;

      return true;
    }else{

      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }


  }

}
