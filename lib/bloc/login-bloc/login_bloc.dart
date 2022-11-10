// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/auth_provider.dart';

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
        print(event.email);
        print(event.password);
        if (result['message'] == "Logged In") {
          prefs.setString('username', event.email);
          prefs.setString('password', event.password);
          emit(LoginSuccess());
        } else {
          emit(LoginError(result['message']));
        }
      } on NetworkError {
        emit(LoginError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
