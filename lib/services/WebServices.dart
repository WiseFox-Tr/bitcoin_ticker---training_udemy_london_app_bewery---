import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/ApiCoinConst.dart';
import 'HttpRequest.dart';

class WebServices {

  static Future<List<CryptoRatio>> getCryptoRate(List<String> cryptoCurrencies, List<String> fiatCurrencies) async {

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

    List<CryptoRatio> cryptoList = [];
    cryptoCurrencies.forEach((crypto) {
      fiatCurrencies.forEach((fiat) {
        cryptoList.add(CryptoRatio(crypto, fiat, data[crypto][fiat].toDouble()));
      });
    });
    return cryptoList;
  }
}
