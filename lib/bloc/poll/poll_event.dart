part of 'poll_bloc.dart';

@immutable
abstract class PollEvent {}

class OnSendMyPolls extends PollEvent{
  final List<Poll> myPolls;
  OnSendMyPolls(this.myPolls);
}

class OnAddMyPolls extends PollEvent{
  final Poll newMyPoll;
  OnAddMyPolls(this.newMyPoll);
}

class OnSendPublicPolls extends PollEvent{
  final List<Poll> publicPolls;
  OnSendPublicPolls(this.publicPolls);
}

class OnSelectPoll extends PollEvent{
  final Poll selectPoll;
  OnSelectPoll(this.selectPoll);
}

class OnActivatePoll extends PollEvent{
  final int id;
  OnActivatePoll(this.id);
}

class OnChekedOptionPoll extends PollEvent{
  final int id;
  OnChekedOptionPoll(this.id);
}

class OnSendVotedPolls extends PollEvent{
  final List<Poll> votedPolls;
  OnSendVotedPolls(this.votedPolls);
}