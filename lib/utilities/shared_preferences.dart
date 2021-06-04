
import 'package:bitcoin_ticker/controller/CoinTickerBrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitcoin_ticker/dataResources/coin_data.dart' as currencies;

final SharedPrefs sharedPrefs = SharedPrefs();

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  static const String _keyFollowedCryptoList = "keyFollowedCryptoNamesList";
  static const String _keyNotFollowedCryptoList = "keyNotFollowedCryptoList";

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

  List<String> get getFollowedCryptoList => _sharedPrefs.getStringList(_keyFollowedCryptoList);
  List<String> get getNotFollowedCryptoList => _sharedPrefs.getStringList(_keyNotFollowedCryptoList);
  set setFollowedCryptoList(List<String> newListString) => _sharedPrefs.setStringList(_keyFollowedCryptoList, newListString);
  set setNotFollowedCryptoList(List<String> newListString) => _sharedPrefs.setStringList(_keyNotFollowedCryptoList, newListString);
}

///Uses SharedPrefs object to save & retrieve followed & not followed crypto lists.
class SharedPreferencesManager {
  static void saveCryptoLists(List<String> followedCryptoList, List<String> notFollowedCryptoList) {
    sharedPrefs.setFollowedCryptoList = followedCryptoList;
    sharedPrefs.setNotFollowedCryptoList = notFollowedCryptoList;
  }
  static void retrieveFollowedCryptoList() => currencies.followedCryptoList = sharedPrefs.getFollowedCryptoList ?? currencies.vanillaCryptoFollowed;
  static void retrieveNotFollowedCryptoList() => currencies.notFollowedCryptoList = sharedPrefs.getNotFollowedCryptoList ?? currencies.vanillaCryptoNotFollowed;
}
