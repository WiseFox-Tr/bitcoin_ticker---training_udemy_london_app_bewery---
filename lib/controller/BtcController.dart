import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/WebServices.dart';
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
    _cryptoRatioList = await WebServices.getCryptoRate(currencies.cryptoCurrencyNames, currencies.fiatCurrencyNames);
    _cryptoRatioList.forEach((crypto) => print(crypto.toString())); //print verification
  }

  ///for each crypto, it save current rate when for this crypto, fiat name & current fiat are same & add a CryptoCardWidget to widget List !
  ///
  ///At the end, it returns the list widget with one CryptoRatioWidget by crypto
  List<Widget> getCurrencyCards () {
    String _currentRate = '?';
    _currencyCards.clear();
    currencies.cryptoCurrencyNames.forEach((cryptoName) {
      _cryptoRatioList.forEach((cryptoRatio) {
        if(cryptoRatio.cryptoName == cryptoName && cryptoRatio.fiatName == _currentFiat) {
          _currentRate = cryptoRatio.rate.toString();
        }
      });
      _currencyCards.add(CryptoRatioCard(cryptoName: cryptoName, rate: _currentRate, fiatName: _currentFiat));
    });
    return _currencyCards;
  }
}
