import 'package:flutter/material.dart';
import 'package:weather_app/HomePage.dart';
import 'package:weather_app/utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: cTextColorPrimary,
                displayColor: Colors.blue,
              )),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
