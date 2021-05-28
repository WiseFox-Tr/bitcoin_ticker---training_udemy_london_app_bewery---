import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/WebServices.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currencies;
import 'package:bitcoin_ticker/utilities/ErrorManager.dart';
import 'package:bitcoin_ticker/view/AppSnackBar.dart';
import 'package:bitcoin_ticker/view/screens/select_crypto_screen.dart';
import 'package:bitcoin_ticker/view/widgets/CryptoRatioCard.dart';
import 'package:flutter/material.dart';

class CoinTickerBrain {

  List<CryptoRatio> _cryptoRatioList = [];
  String _currentFiat = 'USD';
  bool _isLoading = false;

  get getCurrentFiat => _currentFiat;
  get getFiatCurrencies => currencies.fiatCurrencyNames;
  get getIsLoading => _isLoading;
  set setCurrentFiat(String newFiat) => _currentFiat = newFiat;
  set setIsLoading(bool newBool) => _isLoading = newBool;

  ///retrieve crypto & fiat currencies price data or display a custom error message
  Future<void> getCryptoPrices(BuildContext context) async {
    try {
      _cryptoRatioList = await WebServices.getCryptoRate(currencies.cryptoCurrencyNames, currencies.fiatCurrencyNames);
      _cryptoRatioList.forEach((crypto) => print(crypto.toString())); //print verification
    } catch(e) {
      print('exception : $e');
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.getErrorSnackBar(ErrorManager.getErrorForUser(e.toString())));
    }
  }

  ///for each crypto, it saves current rate when for this crypto, fiat name & current fiat are same & add a CryptoCardWidget to widget List !
  ///
  ///At the end, it returns the list widget with one CryptoRatioWidget by crypto
  List<Widget> updateCurrencyCards () {
    List<Widget> _currencyCards = [];
    String _currentRate = '?';
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
    currencies.fiatCurrencyNames.forEach((fiatCurrency) {
      fiatCurrencies.add(Text(fiatCurrency, style: AppConst.pickerTextStyle));
    });
    return fiatCurrencies;
  }

  List<DropdownMenuItem<String>> getAndroidCurrencyItems() {
    return currencies.fiatCurrencyNames.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(value: value, child: Text(value));
    }).toList();
  }

  void goToSelectCryptoScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectCryptoScreen()),
    );
  }
}
