part of 'user_bloc.dart';

class UserState {

  final String email;
  final String password;

  const UserState({
    this.email = '', 
    this.password = ''
  });

  UserState copyWith({
    String? email,
    String? password
  }) => UserState(
    email: email ?? this.email,
    password: password ?? this.password
  );

  @override
  List<Object> get props => [email, password];
}
