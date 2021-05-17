import 'package:bitcoin_ticker/AppItemSelector.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currency;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String _selectedFiatCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: AppConst.mainTextStyle,
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20.0,),
                AppItemSelector(
                  androidDropdownMenuItems: getAndroidCurrencyItems(),
                  androidDefaultValue: _selectedFiatCurrency,
                  onAndroidChanged: (newFiatCurrency) {
                    setState(() => _selectedFiatCurrency = newFiatCurrency);
                  },
                  iosPickerItems: getIosCurrencyItems(),
                  onIosSelectedItemChanged: (index) {
                    print(index);
                    _selectedFiatCurrency = currency.fiatCurrencies[index];
                    print('Current currency : $_selectedFiatCurrency');
                  },
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                  onPressed: null,
                  child: Text(
                    'Check price',
                    style: AppConst.mainTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Text> getIosCurrencyItems() {
    List<Text> fiatCurrencies = [];
    currency.fiatCurrencies.forEach((nationalCurrency) {
      fiatCurrencies.add(Text(nationalCurrency, style: AppConst.pickerTextStyle));
    });
    return fiatCurrencies;
  }

  List<DropdownMenuItem<String>> getAndroidCurrencyItems() {
    return currency.fiatCurrencies.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(value: value, child: Text(value));
    }).toList();
  }
}
