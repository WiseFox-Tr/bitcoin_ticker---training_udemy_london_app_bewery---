import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/WebServices.dart';
import 'package:bitcoin_ticker/dataResources/AppConst.dart';
import 'package:bitcoin_ticker/dataResources/coin_data.dart' as currencies;
import 'package:bitcoin_ticker/utilities/ErrorManager.dart';
import 'package:bitcoin_ticker/view/AppSnackBar.dart';
import 'package:bitcoin_ticker/view/widgets/CryptoRatioCard.dart';
import 'package:flutter/material.dart';

class CoinTickerBrain {

  List<CryptoRatio> _cryptoRatioList = [];

  String _currentFiat = 'USD';
  bool _isLoading = false;

  ///retrieve crypto & fiat currencies price data or display a custom error message
  Future<void> getCryptoPrices(BuildContext context) async {
    try {
      _cryptoRatioList = await WebServices.getCryptoRate(currencies.followedCryptoList, currencies.fiatCurrencyNames);
      _cryptoRatioList.forEach((crypto) => print(crypto.toString())); //print verification
    } catch(e) {
      print('exception : $e');
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.getErrorSnackBar(ErrorManager.getErrorForUser(e.toString())));
    }
  }

  ///for each crypto followed, it saves current rate when for this crypto, fiat name & current fiat are same & add a CryptoCardWidget to widget List !
  ///
  ///At the end, it returns the list widget with one CryptoRatioWidget by crypto followed
  List<Widget> updateCryptoRatioCards() {
    List<Widget> _cryptoRatioCards = [];
    String _currentRate = '?';
    currencies.followedCryptoList.forEach((crypto) {
      _cryptoRatioList.forEach((cryptoRatio) {
        if(cryptoRatio.cryptoName == crypto && cryptoRatio.fiatName == _currentFiat) {
          _currentRate = cryptoRatio.price.toString();
        }
      });
      _cryptoRatioCards.add(CryptoRatioCard(cryptoName: crypto, rate: _currentRate, fiatName: _currentFiat));
    });
    return _cryptoRatioCards;
  }

  ///returns an alphabetic sorted list composed with followed & not followed crypto
  List<String> getAllCryptoList() {
    List<String> allCryptoList = currencies.followedCryptoList + currencies.notFollowedCryptoList;
    allCryptoList.sort((a, b) => a.compareTo(b));
    return allCryptoList;
  }

  /// update followed & not followed crypto lists when user set up his preferences
  void onUpdateCryptoFollowedList(String crypto, bool isFollowed) {
    if(isFollowed) {
      currencies.notFollowedCryptoList.add(crypto);
      currencies.followedCryptoList.remove(crypto);
    } else {
      currencies.followedCryptoList.add(crypto);
      currencies.notFollowedCryptoList.remove(crypto);
    }
    currencies.followedCryptoList.sort((a, b) => a.compareTo(b));
  }

  //-------- APP SELECTOR methods --------------
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

  //-------- GETTERS & SETTERS --------------
  get getCurrentFiat => _currentFiat;
  get getFiatCurrencies => currencies.fiatCurrencyNames;
  get getIsLoading => _isLoading;
  set setCurrentFiat(String newFiat) => _currentFiat = newFiat;
  set setIsLoading(bool newBool) => _isLoading = newBool;
}
