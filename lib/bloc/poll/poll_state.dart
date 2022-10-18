part of 'poll_bloc.dart';

class PollState{

  final List<Poll>? myPolls;
  final List<Poll>? votedPolls;
  final List<Poll>? publicPolls;
  final Poll? selectPoll;

  const PollState({  
    this.myPolls,
    this.publicPolls,
    this.selectPoll,
    this.votedPolls,
  });

  PollState copyWith({
    List<Poll>? myPolls,
    List<Poll>? publicPolls,
    List<Poll>? votedPolls,
    Poll? selectPoll,
  }) => PollState(
    myPolls: myPolls ?? this.myPolls,
    publicPolls: publicPolls ?? this.publicPolls,
    selectPoll: selectPoll ?? this.selectPoll,
    votedPolls: votedPolls ?? this.votedPolls
  );

  List<Object?> get props => [myPolls, publicPolls, selectPoll, votedPolls];

}
