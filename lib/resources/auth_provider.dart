import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

    final data = await json.decode(response.body);
    return data;
  }

}

class NetworkError extends Error {}
