import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoyPages extends StatelessWidget {
  const CategoyPages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: AppBarWidget(),
          ),
        body: Center(
          child: FutureBuilder(

            future: categoryBloc.getCategories(),
            builder: (context, snapshot){

              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(20),
                itemCount: categoryBloc.categories!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index){

                  return CategoryWidget(
                    name: categoryBloc.categories![index].name,
                  );

                }, 
          
              );

            },

          )
        ),
      )
    );
  }
}