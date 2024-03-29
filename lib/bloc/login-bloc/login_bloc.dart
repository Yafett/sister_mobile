// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/auth-provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final _authRepository = AuthProvider();

    on<Login>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        emit(LoginLoading());
        final result = await _authRepository.login(event.email, event.password);

        if (result.toString() == 'error') {
          print('ass : ' + result.toString());
          emit(const LoginError('Your Email or Password is incorrect!'));
        } else {
          print('a : ' + result.toString());
          emit(LoginSuccess(result.toString()));
        }
      } on NetworkError {
        emit(const LoginError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
