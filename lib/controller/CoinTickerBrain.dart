import 'package:bitcoin_ticker/model/CryptoCurrency.dart';
import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/WebServices.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:bitcoin_ticker/utilities/SharedPref.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currencies;
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
      _cryptoRatioList = await WebServices.getCryptoRate(getFollowedCryptoList(), currencies.fiatCurrencyNames);
      _cryptoRatioList.forEach((crypto) => print(crypto.toString())); //print verification
    } catch(e) {
      print('exception : $e');
      ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.getErrorSnackBar(ErrorManager.getErrorForUser(e.toString())));
    }
  }

  ///It try to retrieve crypto followed from SharedPreference.
  ///If success : list data is not empty & each crypto containing gives to cryptoList a true followed status value, else, it gives a false one.
  ///
  ///It should only be called once (into MyApp class).
  static void updateCryptoStatusFromSharedPreferences() {
    List<String> cryptoListAsString = sharedPrefs.getFollowedCryptoNamesList ?? [];
    if(cryptoListAsString.isNotEmpty)
      currencies.cryptoCurrenciesList.forEach((crypto) {
        if(cryptoListAsString.contains(crypto.name)) {
          crypto.isFollowed = true;
        } else {
          crypto.isFollowed = false;
        }
      });
  }

  //it generates a list of strings containing each crypto name followed by user & saves this list into shared preferences.
  void saveNewFollowedCryptoNamesIntoSharedPReferences() {
    List<String> followedCryptoAsStringList = [];
    currencies.cryptoCurrenciesList.forEach((crypto) {
      if(crypto.isFollowed)
        followedCryptoAsStringList.add(crypto.name);
    });
    sharedPrefs.setFollowedCryptoNamesList = followedCryptoAsStringList;
  }

  ///returns a list containing only followed crypto object
  List<CryptoCurrency> getFollowedCryptoList() {
    List<CryptoCurrency> followedCryptoList = [];
    currencies.cryptoCurrenciesList.forEach((crypto) {
      if(crypto.isFollowed)
        followedCryptoList.add(crypto);
    });
    return followedCryptoList;
  }

  ///for each crypto followed, it saves current rate when for this crypto, fiat name & current fiat are same & add a CryptoCardWidget to widget List !
  ///
  ///At the end, it returns the list widget with one CryptoRatioWidget by crypto followed
  List<Widget> updateCryptoRatioCards() {
    List<Widget> _cryptoRatioCards = [];
    String _currentRate = '?';
    getFollowedCryptoList().forEach((crypto) {
      _cryptoRatioList.forEach((cryptoRatio) {
        if(cryptoRatio.cryptoName == crypto.name && cryptoRatio.fiatName == _currentFiat) {
          _currentRate = cryptoRatio.price.toString();
        }
      });
      _cryptoRatioCards.add(CryptoRatioCard(cryptoName: crypto.name, rate: _currentRate, fiatName: _currentFiat));
    });
    return _cryptoRatioCards;
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

  CryptoCurrency getSpecificCryptoCurrency(String cryptoName) => currencies.cryptoCurrenciesList.firstWhere((crypto) => crypto.name == cryptoName);
  void setCryptoCurrencyFollowedStatus(CryptoCurrency cryptoToUpdate, bool newStatus) => cryptoToUpdate.isFollowed = newStatus;


}
