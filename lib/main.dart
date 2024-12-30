import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
          fontFamily: 'Kanit',
          scaffoldBackgroundColor: const Color.fromARGB(255, 226, 234, 226)),
      debugShowCheckedModeBanner: false,
      home: const Home(),
      title: 'Travia',
    ),
  );
}
