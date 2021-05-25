import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/screens/price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.deepOrange,
          accentColor: Colors.red,
          scaffoldBackgroundColor: Colors.grey[900]),
      home: PriceScreen(),
    );
  }
}
