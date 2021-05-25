import 'package:bitcoin_ticker/controller/BtcController.dart';
import 'package:bitcoin_ticker/view/widgets/AppItemSelector.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  BtcController _btcController = BtcController();

  @override
  void initState()  {
    super.initState();
    initScreenValues();
  }

  void initScreenValues() async {
    await _btcController.getCryptoRate();
    setState(() => _btcController.updateCurrencyCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await _btcController.getCryptoRate();
              setState(() => _btcController.updateCurrencyCards());
            },
          ),
        ],
      ),
      body: Column(
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
            color: Colors.lightBlue,
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
    );
  }
}
