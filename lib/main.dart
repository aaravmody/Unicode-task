import 'package:flutter/material.dart';
import 'package:weather/about.dart';
//import 'package:weather/contacts.dart';
import 'package:weather/login.dart';
//import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        //home: Login(),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/about': (context) => About(),
        });
  }
}
