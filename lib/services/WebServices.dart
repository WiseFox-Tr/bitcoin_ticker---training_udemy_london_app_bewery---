import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/privateKey.dart';
import 'HttpRequest.dart';

class WebServices {

  static const String baseURL = 'https://min-api.cryptocompare.com/data/pricemulti';
  static const String apiKey = privateKey;

  static Future<List<CryptoRatio>> getCryptoRate(List<String> cryptoCurrencies, List<String> fiatCurrencies) async {

    String cryptoCurrenciesAsString = '';
    String fiatCurrenciesAsString = '';
    cryptoCurrencies.forEach((crypto) => cryptoCurrenciesAsString += '$crypto,');
    fiatCurrencies.forEach((fiat) => fiatCurrenciesAsString += '$fiat,');

    // url example : https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH&tsyms=USD,EUR&api_key={privateKey}
    Uri url = Uri.parse('$baseURL?fsyms=$cryptoCurrenciesAsString&tsyms=$fiatCurrenciesAsString&api_key=$apiKey');
    dynamic data = await HttpRequest.httpRequestGet(url);

    List<CryptoRatio> cryptoList = [];
    cryptoCurrencies.forEach((crypto) {
      fiatCurrencies.forEach((fiat) {
        cryptoList.add(CryptoRatio(crypto, fiat, data[crypto][fiat].toDouble()));
      });
    });
    return cryptoList;
  }
}
