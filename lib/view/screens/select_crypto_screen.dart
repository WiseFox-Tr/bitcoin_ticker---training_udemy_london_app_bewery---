import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:flutter/material.dart';

class SelectCryptoScreen extends StatefulWidget {
  @override
  _SelectCryptoScreenState createState() => _SelectCryptoScreenState();
}

class _SelectCryptoScreenState extends State<SelectCryptoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConst.strTitle),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.check),
      ),
    );
  }
}
