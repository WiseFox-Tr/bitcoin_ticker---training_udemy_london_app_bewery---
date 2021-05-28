import 'package:bitcoin_ticker/model/CryptoCurrency.dart';

const List<String> fiatCurrencyNames = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'ILS',
  'INR',
  'JPY',
  'NZD',
  'USD',
];

List<CryptoCurrency> cryptoCurrenciesList = [
  CryptoCurrency('AAVE', false),
  CryptoCurrency('BTC', true),
  CryptoCurrency('DOT', false),
  CryptoCurrency('ETH', true),
  CryptoCurrency('LINK', false),
  CryptoCurrency('LTC', true),
  CryptoCurrency('THETA', false),
  CryptoCurrency('XEM', false),
];
