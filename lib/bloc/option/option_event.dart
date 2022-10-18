part of 'option_bloc.dart';

@immutable
abstract class OptionEvent {}

class OnSendDataOption extends OptionEvent{
  final List<Option> options;
  OnSendDataOption(this.options);
}

class OnAddOption extends OptionEvent{
  final Option option;
  OnAddOption(this.option);
}

class OnRemoveOption extends OptionEvent{
  final int id;
  OnRemoveOption(this.id);
}

class OnVoteOption extends OptionEvent{
  final int id;
  OnVoteOption(this.id);
}