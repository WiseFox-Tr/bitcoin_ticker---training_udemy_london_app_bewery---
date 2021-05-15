import 'dart:io' show Platform;

import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppItemSelector extends StatelessWidget {

  final Function onIosSelectedItemChanged;
  final Function onAndroidChanged;
  final String androidDefaultValue;
  final List<Text> iosPickerItems;
  final List<DropdownMenuItem> androidDropdownMenuItems;

  ///AppItemSelector displays a CupertinoPicker on IOS and a DropdownButton on other platforms
  AppItemSelector({
    @required this.onIosSelectedItemChanged,
    @required this.onAndroidChanged,
    @required this.androidDefaultValue,
    @required this.iosPickerItems,
    @required this.androidDropdownMenuItems,
  });

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS) {
      return CupertinoPicker(
          backgroundColor: Colors.lightBlue,
          itemExtent: 32.0,
          onSelectedItemChanged: onIosSelectedItemChanged,
          children: iosPickerItems,
      );
    } else {
      return DropdownButton(
        value: androidDefaultValue,
        items: androidDropdownMenuItems,
        onChanged: onAndroidChanged
      );
    }
  }
}
