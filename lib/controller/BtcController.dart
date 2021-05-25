import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/WebServices.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currencies;
import 'package:bitcoin_ticker/view/widgets/CryptoRatioCard.dart';
import 'package:flutter/material.dart';

class BtcController {

  List<CryptoRatio> _cryptoRatioList = [];
  List<Widget> _currencyCards = [];
  String _currentFiat = 'USD';

  get getCurrentFiat => _currentFiat;
  get getFiatCurrencies => currencies.fiatCurrencyNames;
  set setCurrentFiat(String newFiat) => _currentFiat = newFiat;

  Future<void> getCryptoRate() async {
    try {
      _cryptoRatioList = await WebServices.getCryptoRate(currencies.cryptoCurrencyNames, currencies.fiatCurrencyNames);
      _cryptoRatioList.forEach((crypto) => print(crypto.toString())); //print verification
    } catch(e) {
      print('exception : $e');
    }
  }

  ///for each crypto, it save current rate when for this crypto, fiat name & current fiat are same & add a CryptoCardWidget to widget List !
  ///
  ///At the end, it returns the list widget with one CryptoRatioWidget by crypto
  List<Widget> updateCurrencyCards () {
    String _currentRate = '?';
    _currencyCards.clear();
    currencies.cryptoCurrencyNames.forEach((cryptoName) {
      _cryptoRatioList.forEach((cryptoRatio) {
        if(cryptoRatio.cryptoName == cryptoName && cryptoRatio.fiatName == _currentFiat) {
          _currentRate = cryptoRatio.price.toString();
        }
      });
      _currencyCards.add(CryptoRatioCard(cryptoName: cryptoName, rate: _currentRate, fiatName: _currentFiat));
    });
    return _currencyCards;
  }

  List<Text> getIosCurrencyItems() {
    List<Text> fiatCurrencies = [];
    currencies.fiatCurrencyNames.forEach((nationalCurrency) {
      fiatCurrencies.add(Text(nationalCurrency, style: AppConst.pickerTextStyle));
    });
    return fiatCurrencies;
  }

  List<DropdownMenuItem<String>> getAndroidCurrencyItems() {
    return currencies.fiatCurrencyNames.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(value: value, child: Text(value));
    }).toList();
  }
}
