import 'package:flutter/material.dart';
import 'start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0Xffc8c6ad)
        ),
        backgroundColor: const Color(0Xfff8f6af),
        appBarTheme: const AppBarTheme(
          color: Color(0xff785532)
        )
      ),
      home: StartPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
//TODO: Add authorization: Google , Facebook and via email
//TODO: Try using blockchain