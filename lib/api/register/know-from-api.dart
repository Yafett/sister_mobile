// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sister_mobile/shared/theme.dart';

getKnowFrom() async {
  final response = await http.get(
      Uri.parse('https://${baseUrl}.sekolahmusik.co.id/api/resource/Know From'));

  final data = await json.decode(response.body);

  return data;
}
