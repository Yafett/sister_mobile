// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final String urlLogin = 'https://sister.sekolahmusik.co.id/api/method/login';
  final String urlLogout =
      'https://sister.sekolahmusik.co.id/api/method/logout';

  login(user, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(urlLogin), headers: {
      "Accept": "application/json",
    }, body: {
      "usr": user,
      "pwd": password
    });

    prefs.setString('username', user);
    prefs.setString('password', password);
    
    final data = await json.decode(response.body);
    return data;
  }

  register(Map body) async {
    final response = await http.post(
        Uri.parse(
            'https://sister.sekolahmusik.co.id/api/method/smi.api.registrasi_student'),
        body: body);
  }
}

class NetworkError extends Error {}
