// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../resources/auth_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final _authRepository = AuthProvider();

    on<Login>((event, emit) async {
      try {
        emit(LoginLoading());
        final result = await _authRepository.login(event.email, event.password);
        print(result);
        // if (result['message'] == 'Logged In' ||
        //     result['message'] == 'Invalid login credentials') {
        //   emit(LoginError(result));
        // } else {
        //   emit(LoginSuccess());
        // }
      } on NetworkError {
        emit(LoginError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
 