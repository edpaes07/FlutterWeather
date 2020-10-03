import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:flutter_weather/componentes.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtCidade = TextEditingController();
  TextEditingController txtUF = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();
  int temperatura = 0;
  String cidade = "";
  String data = "";
  String hora = "";
  String descricao = "";

  Function validaCidade = ((value) {
    if (value.isEmpty) {
      return "Cidade inválida";
    }
    return null;
  });

  Function validaUF = ((value) {
    if (value.isEmpty) {
      return "UF inválido";
    }
    return null;
  });

  clicouBotao() async {
    if (!cForm.currentState.validate()) return;
    //String url = "https://flutter_weather.com.br/ws/${txtCEP.text}/json/";

    String url =
        "https://api.hgbrasil.com/weather?key=35c95631&city_name=${txtCidade.text},${txtUF.text}";

    Response resposta = await get(url);
    Map tempo = json.decode(resposta.body);
    setState(() {
      temperatura = tempo["results"]["temp"];
      cidade = tempo["results"]["city"];
      data = tempo["results"]["date"];
      hora = tempo["results"]["time"];
      descricao = tempo["results"]["description"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: cForm,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: new BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/imgs/logo.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Componentes.caixaDeTexto(
                  "Cidade", "Digite a Cidade", txtCidade, validaCidade),
              Componentes.caixaDeTexto("UF", "Digite a UF", txtUF, validaUF),
              Container(
                decoration: new BoxDecoration(color: Colors.blue),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Componentes.rotulo(" "),
                    Componentes.rotulo(
                        "Temperatura: " + temperatura.toString() + "°C"),
                    Componentes.rotulo("Cidade: " + cidade),
                    Componentes.rotulo("Data: " + data),
                    Componentes.rotulo("Hora: " + hora),
                    Componentes.rotulo("Descrição: " + descricao),
                    Componentes.rotulo(" "),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(color: Colors.blue),
                alignment: Alignment.center,
                height: 105,
                child: IconButton(
                  onPressed: clicouBotao,
                  icon: FaIcon(
                    FontAwesomeIcons.cloudRain,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
