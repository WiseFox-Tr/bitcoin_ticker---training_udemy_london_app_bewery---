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
      _cryptoRatioList = await WebServices.getCryptoPrice(currencies.currentFollowedCryptoList, currencies.fiatCurrencyList);
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
    List<Widget> cryptoRatioCards = [];
    String currentPrice = '?';
    currencies.currentFollowedCryptoList.forEach((crypto) {
      _cryptoRatioList.forEach((cryptoRatio) {
        if(cryptoRatio.cryptoName == crypto && cryptoRatio.fiatName == _currentFiat)
          currentPrice = cryptoRatio.price.toString();
      });
      cryptoRatioCards.add(CryptoRatioCard(cryptoName: crypto, price: currentPrice, fiatName: _currentFiat));
    });
    return cryptoRatioCards;
  }

  ///returns an alphabetic sorted list composed with followed & not followed crypto
  List<String> getAllCryptoByAlphabeticOrder() {
    List<String> allCrypto = currencies.vanillaFollowedCryptoList + currencies.vanillaNotFollowedCryptoList;
    allCrypto.sort((a, b) => a.compareTo(b));
    return allCrypto;
  }

  /// update followed & not followed crypto lists when user set up his preferences
  void updateFollowedCryptoList(String crypto, bool isFollowed) {
    if(isFollowed) {
      currencies.currentNotFollowedCryptoList.add(crypto);
      currencies.currentFollowedCryptoList.remove(crypto);
    } else {
      currencies.currentFollowedCryptoList.add(crypto);
      currencies.currentNotFollowedCryptoList.remove(crypto);
    }
    currencies.currentFollowedCryptoList.sort((a, b) => a.compareTo(b));
  }

  //-------- APP SELECTOR methods --------------
  List<Text> getIosCurrencyItems() {
    List<Text> fiatCurrencyItems = [];
    currencies.fiatCurrencyList.forEach((fiatCurrency) {
      fiatCurrencyItems.add(Text(fiatCurrency, style: AppConst.pickerTextStyle));
    });
    return fiatCurrencyItems;
  }

  List<DropdownMenuItem<String>> getAndroidCurrencyItems() {
    return currencies.fiatCurrencyList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem(value: value, child: Text(value));
    }).toList();
  }

  //-------- GETTERS & SETTERS --------------
  get getCurrentFiat => _currentFiat;
  get getFiatCurrencyList => currencies.fiatCurrencyList;
  get getIsLoading => _isLoading;
  set setCurrentFiat(String newFiat) => _currentFiat = newFiat;
  set setIsLoading(bool newBool) => _isLoading = newBool;
}
