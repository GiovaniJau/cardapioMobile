import 'package:cardapio_mobile/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cardápio Mobile',
      theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: const HomeScreen(),
    );
  }
}
