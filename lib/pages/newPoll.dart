import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/theme/theme.dart';
import 'package:encuesta_flutter/widget/appBarWidget.dart';
import 'package:encuesta_flutter/widget/buttonWidget.dart';
import 'package:encuesta_flutter/widget/formTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewPollPages extends StatefulWidget {
  const NewPollPages({ Key? key }) : super(key: key);

  @override
  State<NewPollPages> createState() => _NewPollPagesState();
}

class _NewPollPagesState extends State<NewPollPages> {

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  
  int? selectItem;
  DateTime initDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final TextEditingController questionController = TextEditingController();
  final TextEditingController initDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(125),
          child: AppBarWidget(),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
          child: SingleChildScrollView (
            physics: const ScrollPhysics(),
            child: FutureBuilder<bool>(
              future: categoryBloc.getCategories(),
              builder: (context, snapshot) {
          
                if (snapshot.hasData){
                  if (snapshot.data == true){
                    return _formNewPoll(context);
                  }else{
                    return const Center(child: Text('Error'),);
                  }
                }else{
                  return const Center(child: Text('Cargando'),);
                }
              },
          
          
          
          
            ),
          ),
        ),
      )
    );
  }

  Widget _formNewPoll(BuildContext context) {

    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    final pollBloc = BlocProvider.of<PollBloc>(context);


    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12, top: 10),
          child: Text('Nueva encuesta'.toUpperCase(), style: TextStyle(color: ColorTheme.colorPrimary, fontWeight: FontWeight.bold),),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: FormTextWidget(
            title: 'Fecha para iniciar encuesta',
            isIcon: true,
            icon: const Icon(Icons.date_range),
            controller: initDateController,
            keyboardType: TextInputType.none,
            onTap: (){
              // Aqui viene el dataPicket
              _datePicketInit(context);
            },
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: FormTextWidget(
            title: 'Fecha para la finalizacion de la encuesta',
            isIcon: true,
            icon: const Icon(Icons.date_range),
            controller: endDateController,
            keyboardType: TextInputType.none,
            onTap: () async{
              // Aqui viene el dataPicket
              _datePicketEnd(context);
            },
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Categoria',
              icon: Icon(Icons.category),
              fillColor: Color(0x00000000)
            ),
            items: categoryBloc.categories!.map((category) => 
              DropdownMenuItem(
                value: category.id,
                child: Text(category.name),
              )
            ).toList(),
            onChanged: (newVal){
              setState(() {
                selectItem = int.parse(newVal.toString());
              });
            },
            value: selectItem,
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: FormTextWidget(
            title: 'Pregunta',
            icon: const Icon(Icons.question_mark),
            maxLine: 8,
            controller: questionController,
          ),
        ),



        ButtonWidget(
          title: 'Crear',
          onPressed: () async{
            
            if (
              questionController.text.trim().isNotEmpty && 
              initDateController.text.trim().isNotEmpty &&
              endDateController.text.trim().isNotEmpty &&
              selectItem != null
            ){
              
              final navigator = Navigator.of(context);
              final status = await pollBloc.createPoll(questionController.value.text, initDate, endDate, selectItem!);
          
              if (status){
                // navigator.pop();
                navigator.pushReplacementNamed('addOptions');
              }else{
                print('Error');
              }
          
            }
          
          },
        )
      ],
    );
  }

  Future _datePicketInit(BuildContext context) async{
    final DateTime? picket = await showDatePicker(
      context: context, 
      initialDate: initDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picket != null){
      setState(() {
        initDate = picket;
        initDateController.text = formatter.format(initDate);
      });
    }
  }

    Future _datePicketEnd(BuildContext context) async{
    final DateTime? picket = await showDatePicker(
      context: context, 
      initialDate: endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picket != null){
      setState(() {
        endDate = picket;
        endDateController.text = formatter.format(endDate);
      });
    }
  }
}