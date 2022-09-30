// ignore_for_file: override_on_non_overriding_member

part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class Logout extends LoginEvent {}
