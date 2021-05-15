import 'package:bitcoin_ticker/AppItemSelector.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currency;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String _selectedCurrency = 'USD';

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
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: AppItemSelector(
              androidDropdownMenuItems: getAndroidCurrencyItems(),
              androidDefaultValue: _selectedCurrency,
              onAndroidChanged: (newCurrency) {
                setState(() => _selectedCurrency = newCurrency);
              },
              iosPickerItems: getIosCurrencyItems(),
              onIosSelectedItemChanged: (index) {
                print(index);
                _selectedCurrency = currency.currenciesList[index];
                print('Current currency : $_selectedCurrency');
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Text> getIosCurrencyItems() {
    List<Text> currencies = [];
    currency.currenciesList.forEach((nationalCurrency) => currencies.add(Text(nationalCurrency)));
    return currencies;
  }

  List<DropdownMenuItem<String>> getAndroidCurrencyItems() {
    return currency.currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(value: value, child: Text(value));
    }).toList();
  }
}
