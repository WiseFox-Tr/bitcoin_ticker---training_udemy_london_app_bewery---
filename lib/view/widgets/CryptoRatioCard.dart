import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:flutter/material.dart';

class CryptoRatioCard extends StatelessWidget{

  final String cryptoName;
  final String rate;
  final String fiatName;

  CryptoRatioCard({
    @required this.cryptoName,
    @required this.rate,
    @required this.fiatName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.orange,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoName = $rate $fiatName',
            textAlign: TextAlign.center,
            style: AppConst.mainTextStyle,
          ),
        ),
      ),
    );
  }
}
