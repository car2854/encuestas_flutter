import 'package:bloc/bloc.dart';
import 'package:encuesta_flutter/bloc/bloc.dart';
import 'package:encuesta_flutter/models/models.dart';
import 'package:encuesta_flutter/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'poll_event.dart';
part 'poll_state.dart';

class PollBloc extends Bloc<PollEvent, PollState> {

  ErrorResponse? error;

  PollService pollService = PollService();
  final UserBloc userBloc;

  PollBloc({
    required this.userBloc
  }) : super(const PollState()) {
    on<PollEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnSendMyPolls>((event, emit){
      emit(state.copyWith(myPolls: event.myPolls));
    });

    on<OnSendVotedPolls>((event, emit){
      emit(state.copyWith(votedPolls: event.votedPolls));
    });
    
    on<OnAddMyPolls>((event, emit){
      List<Poll>? copyMyPoll = state.myPolls;
      copyMyPoll!.add(event.newMyPoll);
      emit(state.copyWith(myPolls: copyMyPoll));
    });
    
    on<OnSendPublicPolls>((event, emit){

      List<Poll> copyPolls = [];

      for (var poll in event.publicPolls) {
        
        bool exist = false;

        if (poll.participates != null) {
          for (var participate in poll.participates!) {
            
            if (participate.userId == userBloc.user!.id){
              exist = true;
            }

          }
        }

        if (!exist){
          copyPolls.add(poll);
        }


      }



      emit(state.copyWith(publicPolls: copyPolls));
    });

    on<OnSelectPoll>((event, emit) {
      emit(state.copyWith(selectPoll: event.selectPoll));
    });
    
    on<OnChekedOptionPoll>((event, emit) {

      List<Poll> newPublicPolls = [];

      for (var poll in state.publicPolls!) {

        if (poll.id == event.id) {

          Participate participate = Participate(
            id: 1, 
            participateUserId: 1, 
            participatePollId: 1, 
            participateOptionId: 1, 
            optionId: 1, 
            pollId: 1, 
            userId: userBloc.user!.id
          );

          if (poll.participates==null){
            poll.participates = <Participate>[participate];
            print(poll.participates);
          }else{
            poll.participates!.add(participate);
            print('aqui');
          }

        }

        newPublicPolls.add(poll);
      }

      emit(state.copyWith(publicPolls: newPublicPolls));
    });

    on<OnActivatePoll>((event, emit) {
      final List<Poll> newPolls = [];

      for (var poll in state.myPolls!) {
        if (poll.id == event.id) poll.isActive = true;
        newPolls.add(poll);
      }

      emit(state.copyWith(myPolls: newPolls));
    });
    
  }

  Future<bool> getVotedPolls() async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await pollService.getVotedPolls(token);

    if (resp.statusCode == 200){
      final publicPollsResponse = publicPollsResponseFromJson(resp.body);
      add(OnSendVotedPolls(publicPollsResponse.polls));
      return true;
    }else{
      
      error = errorResponseFromJson(resp.body);

      return false;
    }

  }

  Future<bool> getPublicPolls() async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await pollService.getPublicPolls(token);

    if (resp.statusCode == 200){
      final publicPollsResponse = publicPollsResponseFromJson(resp.body);
      add(OnSendPublicPolls(publicPollsResponse.polls));
      return true;
    }else{
      
      error = errorResponseFromJson(resp.body);

      return false;
    }

  }

  Future<bool> getMyPolls() async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await pollService.getMyPolls(token);

    if (resp.statusCode == 200){

      final pollResponse = pollResponseFromJson(resp.body);
      add(OnSendMyPolls(pollResponse.polls));

      return true;
    }else{
      error = errorResponseFromJson(resp.body);

      print(resp.body);
      return false;
    }

  }

  Future<bool> createPoll(String description,DateTime initPoll,DateTime endPoll,int categoryId)async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await pollService.createPoll(description, initPoll, endPoll, categoryId, token);

    if (resp.statusCode == 200){
      
      final newPollResponse = newPollResponseFromJson(resp.body);

      add(OnAddMyPolls(newPollResponse.newPoll));
      add(OnSelectPoll(newPollResponse.newPoll));

      return true;
    }else{

      error = errorResponseFromJson(resp.body);

      print(resp.body);
      return false;
    }

  }

  Future<bool> activatedPoll(int id) async{

    final token = await userBloc.storage.read(key: 'token') ?? '';

    final Response resp = await pollService.activatedPoll(id, token);


    if (resp.statusCode == 200){
      print(resp.body);
      add(OnActivatePoll(id));
      return true;
    }else{
      error = errorResponseFromJson(resp.body);
      print(resp.body);
      return false;
    }
  
  }
}
