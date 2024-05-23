part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSignup extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  const AuthenticationSignup(
      {required this.name, required this.email, required this.password});
}

class AuthenticationSignin extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationSignin({required this.email, required this.password});
}

class AuthenticationCheck extends AuthenticationEvent {}
