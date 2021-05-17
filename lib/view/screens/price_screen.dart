import 'package:bitcoin_ticker/controller/BtcController.dart';
import 'package:bitcoin_ticker/view/widgets/AppItemSelector.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  BtcController _btcController = BtcController();

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
                  androidDefaultValue: _btcController.getCurrentFiat,
                  onAndroidChanged: (newFiatCurrency) {
                    setState(() => _btcController.setCurrentFiat = newFiatCurrency);
                    print('Current fiat currency : ${_btcController.getCurrentFiat}');
                  },
                  iosPickerItems: getIosCurrencyItems(),
                  onIosSelectedItemChanged: (index) {
                    print(index);
                    _btcController.setCurrentFiat = _btcController.getFiatCurrencies[index];
                    print('Current fiat currency : ${_btcController.getCurrentFiat}');
                  },
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                  onPressed: () async {
                    await _btcController.getCryptoRate();
                  },
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
    _btcController.getFiatCurrencies.forEach((nationalCurrency) {
      fiatCurrencies.add(Text(nationalCurrency, style: AppConst.pickerTextStyle));
    });
    return fiatCurrencies;
  }

  List<DropdownMenuItem<String>> getAndroidCurrencyItems() {
    return _btcController.getFiatCurrencies.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(value: value, child: Text(value));
    }).toList();
  }
}
