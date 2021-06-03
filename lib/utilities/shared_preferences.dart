
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currencies;
import 'package:shared_preferences/shared_preferences.dart';

final SharedPrefs sharedPrefs = SharedPrefs();

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  static const String _keyFollowedCryptoNamesList = "keyFollowedCryptoNamesList";

  Future init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  Future clear() async {
    if(_sharedPrefs != null) {
      _sharedPrefs = await SharedPreferences.getInstance();
      _sharedPrefs.clear();
    }
  }

  List<String> get getFollowedCryptoNamesList => _sharedPrefs.getStringList(_keyFollowedCryptoNamesList);
  set setFollowedCryptoNamesList(List<String> newListString) => _sharedPrefs.setStringList(_keyFollowedCryptoNamesList, newListString);
}

///This class allow :
///- to find crypto names list stored into shared preferences & update crypto followed status
///- to save new crypto names list followed by user
class SharedPreferencesManager {
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
  static void saveNewFollowedCryptoNamesIntoSharedPReferences() {
    List<String> followedCryptoAsStringList = [];
    currencies.cryptoCurrenciesList.forEach((crypto) {
      if(crypto.isFollowed)
        followedCryptoAsStringList.add(crypto.name);
    });
    sharedPrefs.setFollowedCryptoNamesList = followedCryptoAsStringList;
  }
}
