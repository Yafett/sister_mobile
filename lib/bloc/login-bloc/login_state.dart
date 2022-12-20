part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String? role;
  const LoginSuccess(this.role);
}

class LoginError extends LoginState {
  final String? message;
  const LoginError(this.message);
}
