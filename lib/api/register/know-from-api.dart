// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;

getKnowFrom() async {
  final response = await http.get(
      Uri.parse('https://sister.sekolahmusik.co.id/api/resource/Know From'));

  final data = await json.decode(response.body);

  return data;
}
