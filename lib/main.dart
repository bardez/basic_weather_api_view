import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Current weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Current weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _localController = TextEditingController();
  final String _instructions = 'Please fill the local based on model: Country, State, City';
  late Map _response = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_instructions),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _localController,
                decoration: InputDecoration(
                  hintText: 'Country, State, City'
                ),
              ),
            ),Visibility(
              visible: _response.isNotEmpty,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children :[
                      Text("Today's  time: "),
                      Text("Condition: ${_response.isNotEmpty ? _response['forecast']['forecastday'][0]['day']['condition']['text'] : ''}"),
                      Text("Average temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][0]['day']['avgtemp_f'] : ''}º F"),
                      Text("Min temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][0]['day']['mintemp_f'] : ''}º F"),
                      Text("Max temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][0]['day']['maxtemp_f'] : ''}º F")
                    ]
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _response.isNotEmpty,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children :[
                      Text(_response.isNotEmpty? _response['forecast']['forecastday'][1]['date'] : ""),
                      Text("Condition: ${_response.isNotEmpty ? _response['forecast']['forecastday'][1]['day']['condition']['text'] : ''}"),
                      Text("Average temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][1]['day']['avgtemp_f'] : ''}º F"),
                      Text("Min temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][1]['day']['mintemp_f'] : ''}º F"),
                      Text("Max temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][1]['day']['maxtemp_f'] : ''}º F")
                    ]
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _response.isNotEmpty,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children :[
                      Text(_response.isNotEmpty ? _response['forecast']['forecastday'][2]['date']: ""),
                      Text("Condition: ${_response.isNotEmpty ? _response['forecast']['forecastday'][2]['day']['condition']['text'] : ''}"),
                      Text("Average temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][2]['day']['avgtemp_f'] : ''}º F"),
                      Text("Min temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][2]['day']['mintemp_f'] : ''}º F"),
                      Text("Max temperature: ${_response.isNotEmpty ? _response['forecast']['forecastday'][2]['day']['maxtemp_f'] : ''}º F")
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => getweather(_localController.text),
        label: Text('Get weather')
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  getweather(String local) async {
    var url = Uri.parse('http://api.weatherapi.com/v1/forecast.json?key=dc9ffce7650b4352926221056211905&q=${local.trim()}&days=3&aqi=no&alerts=no');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); 
    setState((){
      _response = jsonDecode(response.body);
    });
  }
}
