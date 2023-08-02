import 'package:flutter/material.dart';
import 'package:osym_sinav/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sınav Puan Hesaplama',
      home: HomePage(),
    );
  }
}
