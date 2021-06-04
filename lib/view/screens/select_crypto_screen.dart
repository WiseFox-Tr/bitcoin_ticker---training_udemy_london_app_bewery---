import 'package:bitcoin_ticker/controller/CoinTickerBrain.dart';
import 'package:bitcoin_ticker/utilities/AppConst.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart' as currencies;
import 'package:bitcoin_ticker/view/widgets/CryptoNameCard.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';

class SelectCryptoScreen extends StatefulWidget {
  @override
  _SelectCryptoScreenState createState() => _SelectCryptoScreenState();
}

class _SelectCryptoScreenState extends State<SelectCryptoScreen> {

  CoinTickerBrain _coinTickerBrain = CoinTickerBrain();

  ///get a CryptoNameCard List composed with all cryptoCurrency objects
  List<Widget> updateCryptoNameCards() {
    List<Widget> _cryptoNameCards = [];
    _coinTickerBrain.getAllCryptoList().forEach((crypto) {
      bool isFollowed = currencies.cryptoFollowed.contains(crypto);
      _cryptoNameCards.add(
        CryptoNameCard(
          label: crypto,
          isFollowed: isFollowed,
          onTap: () => setState(() => _coinTickerBrain.onUpdateCryptoFollowedList(crypto, isFollowed)),
        ),
      );
    });
    return _cryptoNameCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConst.strTitle),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _coinTickerBrain.getIsLoading,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            crossAxisCount: 3,
            children: updateCryptoNameCards(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          // SharedPreferencesManager.saveNewFollowedCryptoNamesIntoSharedPReferences();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
