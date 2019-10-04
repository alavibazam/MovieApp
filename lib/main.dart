import 'package:flutter/material.dart';
import 'package:MovieApp/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App 2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage('Movies (APU SDS)'),
    );
  }
}