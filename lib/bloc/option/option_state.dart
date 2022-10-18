part of 'option_bloc.dart';

class OptionState{

  final List<Option>? options;

  const OptionState({  
    this.options
  });

  OptionState copyWith({
    List<Option>? options
  }) => OptionState(
    options: options ?? this.options
  );

  List<Object?> get props => [options];

}