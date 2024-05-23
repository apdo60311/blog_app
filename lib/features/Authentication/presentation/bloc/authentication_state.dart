part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  final User user;

  const AuthenticationSuccessState({required this.user});
}

class AuthenticationFailureState extends AuthenticationState {
  final String message;

  const AuthenticationFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
