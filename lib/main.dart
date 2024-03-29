import 'package:flutter/material.dart';
import 'package:flutter_api_intgrate/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange[100],
          // ignore: prefer_const_constructors
          appBarTheme: AppBarTheme(elevation: 0.0)),
      home: const HomeScreen(),
    );
  }
}
