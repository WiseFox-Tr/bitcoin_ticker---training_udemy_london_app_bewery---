import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:flutter/material.dart';

class CryptoNameCard extends StatelessWidget {

  final String label;
  final bool isFollowed;
  final Function onTap;

  CryptoNameCard({@required this.label, @required this.isFollowed, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isFollowed ? Colors.orange : Colors.orange[100],
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Text(label, style: AppConst.mainTextStyle, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
