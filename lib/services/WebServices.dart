import 'package:bitcoin_ticker/model/Crypto.dart';
import 'package:bitcoin_ticker/services/ApiCoinConst.dart';
import 'HttpRequest.dart';

class WebServices {

  static Future<List<Crypto>> getCryptoRate(List<String> cryptoCurrencies, List<String> fiatCurrencies) async {

    String cryptoCurrenciesAsString = '';
    String fiatCurrenciesAsString = '';
    cryptoCurrencies.forEach((crypto) => cryptoCurrenciesAsString += '$crypto,');
    fiatCurrencies.forEach((fiat) => fiatCurrenciesAsString += '$fiat,');

    Uri url = Uri.https(
      ApiCoinConst.authority,
      ApiCoinConst.unencodedPath,
      {
        'fsyms' : cryptoCurrenciesAsString ,
        'tsyms' : fiatCurrenciesAsString,
        'api_key' : ApiCoinConst.apiKey
      }
    );

    dynamic data = await HttpRequest.httpRequestGet(url);

    List<Crypto> cryptoList = [];
    cryptoCurrencies.forEach((crypto) {
      fiatCurrencies.forEach((fiat) {
        cryptoList.add(Crypto(crypto, fiat, data[crypto][fiat].toDouble()));
      });
    });
    return cryptoList;
  }
}
