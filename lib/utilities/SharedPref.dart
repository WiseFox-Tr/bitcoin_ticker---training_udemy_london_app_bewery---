
import 'package:shared_preferences/shared_preferences.dart';

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

final SharedPrefs sharedPrefs = SharedPrefs();
