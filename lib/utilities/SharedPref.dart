
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  static const String _keyFollowedCryptoAsStrings = "keyFollowedCryptoNamesList";

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

  String get getFollowedCryptoAsString => _sharedPrefs.getString(_keyFollowedCryptoAsStrings);
  set setFollowedCryptoAsString(String newString) => _sharedPrefs.setString(_keyFollowedCryptoAsStrings, newString);
}

final SharedPrefs sharedPrefs = SharedPrefs();
