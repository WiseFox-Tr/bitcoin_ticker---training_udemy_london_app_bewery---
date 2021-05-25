import 'package:bitcoin_ticker/controller/BtcController.dart';
import 'package:bitcoin_ticker/view/widgets/AppItemSelector.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  CoinTickerBrain _btcController = CoinTickerBrain();
  bool _isLoading = false;

  @override
  void initState()  {
    super.initState();
    getScreenValues();
  }

  void getScreenValues() async {
    setState(() => _isLoading = true);
    await _btcController.getCryptoRate();
    setState(() {
      _btcController.updateCurrencyCards();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async => getScreenValues()
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: SingleChildScrollView(
                child: Column(
                  children: _btcController.updateCurrencyCards()
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.deepOrange,
              alignment: Alignment.center,
              child: AppItemSelector(
                androidDropdownMenuItems: _btcController.getAndroidCurrencyItems(),
                androidDefaultValue: _btcController.getCurrentFiat,
                onAndroidChanged: (newFiatCurrency) {
                  setState(() => _btcController.setCurrentFiat = newFiatCurrency);
                },
                iosPickerItems: _btcController.getIosCurrencyItems(),
                onIosSelectedItemChanged: (index) {
                  setState(() => _btcController.setCurrentFiat = _btcController.getFiatCurrencies[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
