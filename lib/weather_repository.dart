import 'package:curso_flutter/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Weather> getWeather() async {
  final String url = 'https://api.hgbrasil.com/weather';

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return Weather.fromJson(json.decode(response.body));
  } else {
    throw Exception("Problema de Conexão");
  }
}
