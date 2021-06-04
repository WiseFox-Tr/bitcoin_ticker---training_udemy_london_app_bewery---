import 'package:flutter/material.dart';

class AppConst {
  static const TextStyle pickerTextStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle dropdownStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  static const TextStyle mainTextStyle = TextStyle(color: Colors.black87 ,fontSize: 20.0, fontWeight: FontWeight.w800);

  static const String strTitle = 'Coin Ticker';
  static const String strBaseErrorMessage = "Oups, nous n'avons pas réussi à récupérer les données";
  static const String strCheckInternetConnectionError = "$strBaseErrorMessage, pensez à vérifier votre connexion internet ou réessayez plus tard.";
  static const String strDefaultError = '$strBaseErrorMessage, réessayez plus tard !';
}
