
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
  set setFollowedCryptoList(List<String> newListString) => _sharedPrefs.setStringList(_keyFollowedCryptoList, newListString);
}

///Uses SharedPrefs object to save & retrieve followed & not followed crypto lists.
class SharedPreferencesManager {
  static void saveFollowedCryptoList(List<String> followedCryptoList, List<String> notFollowedCryptoList) => sharedPrefs.setFollowedCryptoList = followedCryptoList;
  ///Fill a current followed crypto list & generate not followed list by checking
  ///for each crypto if they are into followed list or not, if not -> they are added into not followed list.
  static void retrieveFollowedCryptoList() {
    currencies.currentFollowedCryptoList.clear();
    currencies.currentNotFollowedCryptoList.clear();
    currencies.currentFollowedCryptoList.addAll(sharedPrefs.getFollowedCryptoList ?? currencies.vanillaCryptoFollowed);
    List<String> allCryptoList = currencies.vanillaCryptoNotFollowed + currencies.vanillaCryptoNotFollowed;
    allCryptoList.forEach((crypto) {
      if(!currencies.currentFollowedCryptoList.contains(crypto))
        currencies.currentNotFollowedCryptoList.add(crypto);
    });
  }
}
