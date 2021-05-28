import 'package:bitcoin_ticker/controller/CoinTickerBrain.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:bitcoin_ticker/view/screens/select_crypto_screen.dart';
import 'package:bitcoin_ticker/view/widgets/AppItemSelector.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  CoinTickerBrain _coinTickerBrain = CoinTickerBrain();

  @override
  void initState()  {
    super.initState();
    getScreenValues();
  }

  ///launch progress indicator, getCryptoData, update UI & stop progress indicator
  void getScreenValues() async {
    setState(() => _coinTickerBrain.setIsLoading = true);
    await _coinTickerBrain.getCryptoPrices(context);
    setState(() {
      _coinTickerBrain.updateCryptoRatioCards();
      _coinTickerBrain.setIsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConst.strTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async => getScreenValues()
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _coinTickerBrain.getIsLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView(
                children: _coinTickerBrain.updateCryptoRatioCards(),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.deepOrange,
              alignment: Alignment.center,
              child: AppItemSelector(
                androidDropdownMenuItems: _coinTickerBrain.getAndroidCurrencyItems(),
                androidDefaultValue: _coinTickerBrain.getCurrentFiat,
                onAndroidChanged: (newFiatCurrency) {
                  setState(() => _coinTickerBrain.setCurrentFiat = newFiatCurrency);
                },
                iosPickerItems: _coinTickerBrain.getIosCurrencyItems(),
                onIosSelectedItemChanged: (index) {
                  setState(() => _coinTickerBrain.setCurrentFiat = _coinTickerBrain.getFiatCurrencies[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectCryptoScreen()),
          ).then((value) => getScreenValues());
        }
      ),
    );
  }
}
