import 'package:bloc/bloc.dart';
import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/models/models.dart';
import 'package:encuesta_flutter/models/models/detailOption.dart';
import 'package:encuesta_flutter/services/option.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'option_event.dart';
part 'option_state.dart';

class OptionBloc extends Bloc<OptionEvent, OptionState> {

  final UserBloc userBloc;
  final PollBloc pollBloc;
  OptionService optionService = OptionService();
  ErrorResponse? error;
  DetailOption? detailOptions;

  Participate? participate;

  OptionBloc({
    required this.userBloc,
    required this.pollBloc
  }) : super(const OptionState()) {
    
    on<OnAddOption>((event, emit) {
      final List<Option>? options = state.options;
      options!.add(event.option);
      emit(state.copyWith(options: options));
    });

    on<OnSendDataOption>((event, emit) {
      emit(state.copyWith(options: event.options));
    });

    on<OnRemoveOption>((event, emit) {
      final List<Option>? options = state.options;
      Option? optionDelete;
      for (var option in options!) {
        if (option.id == event.id){
          optionDelete = option;
        }
      }
      options.remove(optionDelete);
      emit(state.copyWith(options: options));
    });

    on<OnVoteOption>((event, emit) {
      
      final List<Option> newOptions = [];

      if (state.options == null) return;

      for (var option in state.options!) {
        if (option.id == event.id) option.amountVote = option.amountVote + 1;
        newOptions.add(option);
      }

      emit(state.copyWith(options: newOptions));
    });

  }


  Future<bool> getPublicOptions(int id) async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await optionService.getPublicOptions(id, token);

    if (resp.statusCode == 200){
      final getPublicOptionsResponse = getPublicOptionsResponseFromJson(resp.body);
      add(OnSendDataOption(getPublicOptionsResponse.options));
      participate = getPublicOptionsResponse.participate;
      return true;
    }else{
      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }
  }

  Future<bool> getOptions(int id) async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await optionService.getOptions(id, token);

    if (resp.statusCode == 200){
      final getOptionsResponse = getOptionsResponseFromJson(resp.body);
      add(OnSendDataOption(getOptionsResponse.options));
      return true;
    }else{
      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }
  }

  Future<bool> addOption(String name, int id)async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await optionService.addOption(name, id, token);

    if (resp.statusCode == 200){

      final newOptionResponse = newOptionResponseFromJson(resp.body);
      add(OnAddOption(newOptionResponse.newOption));
      return true;
    }else{

      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }
  }

  Future<bool> deleteOption(int id)async {
    final token = await userBloc.storage.read(key: 'token') ?? '';
    final Response resp = await optionService.deleteOption(id, token);
    
    if (resp.statusCode == 200){
      add(OnRemoveOption(id));
      return true;
    }else{
      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }
  }

  Future<bool> voteOption(int id, int idPoll) async{

    final token = await userBloc.storage.read(key: 'token') ?? ';';

    final Response resp = await optionService.newVoteOption(id, token);

    if (resp.statusCode == 200){
      // TODO: Nose que es esto
      pollBloc.add(OnChekedOptionPoll(idPoll));
      // add(OnVoteOption(id));
      return true;
    }else{
      print(resp.body);
      error = errorResponseFromJson(resp.body);
      return false;
    }

  }

  Future<bool> getDetailsOptionComplete(int id) async{

    final token = await userBloc.storage.read(key: 'token') ?? ';';

    final Response resp = await optionService.getDetailsOptionComplete(id, token);

    if (resp.statusCode == 200){
      final getDetailOptionResponse = getDetailOptionResponseFromJson(resp.body);
      detailOptions = getDetailOptionResponse.detailOption;
      return true;
    }else{
      print(resp.body);
      error = errorResponseFromJson(resp.body);
      return false;
    }

  }
  
}
