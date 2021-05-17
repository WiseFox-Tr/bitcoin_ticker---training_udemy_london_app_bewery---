import 'package:bitcoin_ticker/model/Crypto.dart';
import 'package:bitcoin_ticker/services/WebServices.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currencies;

class BtcController {


  List<String> _fiatCurrencies = currencies.fiatCurrencies;
  List<String> _cryptoCurrencies = currencies.cryptoCurrencies;

  List<Crypto> _cryptoList = [];
  String _currentFiat = 'USD';

  get getCurrentFiat => _currentFiat;
  get getFiatCurrencies => _fiatCurrencies;
  set setCurrentFiat(String newFiat) => _currentFiat = newFiat;

  Future<void> getCryptoRate() async {
    _cryptoList = await WebServices.getCryptoRate(_cryptoCurrencies, _fiatCurrencies);
    _cryptoList.forEach((element) => print(element.toString())); //print verification
  }
}
