import 'package:coin_watcher/coin_card.dart';
import 'package:coin_watcher/exchange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:coin_watcher/constants.dart' as constants;

class PricePage extends StatefulWidget {
  const PricePage({Key? key}) : super(key: key);

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  ExchangeHandler exchangeHandler = ExchangeHandler();
  String selectedCurrency = 'USD';
  List<CoinCard> coinCards = [];

  Widget getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      children: [
        for (String item in constants.currencies) Text(item),
      ],
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = constants.currencies[index];
          updateExchangeRateCards(selectedCurrency);
        });
      },
    );
  }

  Widget getDropDownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: [
        for (String item in constants.currencies)
          DropdownMenuItem(child: Text(item), value: item),
      ],
      onChanged: (value) {
        setState(() {
          selectedCurrency = value ?? 'USD';
          updateExchangeRateCards(selectedCurrency);
        });
      },
    );
  }

  void initExchangeRateCards(String currency) async {
    dynamic response = await exchangeHandler.getExchangeRateInfo(currency);
    for (var item in response['rates']) {
      String coin = item['asset_id_quote'];
      if (constants.coins.contains(coin)) {
        double rate = item['rate'];
        String exchangeRateString =
            '1 $coin = ${rate.toStringAsFixed(6)} $currency';
        coinCards.add(CoinCard(
          label: exchangeRateString,
        ));
      }
    }
  }

  void updateExchangeRateCards(String currency) async {
    dynamic response = await exchangeHandler.getExchangeRateInfo(currency);
    print(response);
    int count = 0;
    for (dynamic item in response['rates']) {
      String coin = item['asset_id_quote'];
      if (constants.coins.contains(coin)) {
        double rate = item['rate'];
        String exchangeRateString =
            '1 $coin = ${rate.toStringAsFixed(6)} $currency';
        coinCards[count].updateLabel(exchangeRateString);
        count++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCurrency = 'USD';
    initExchangeRateCards(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Watcher'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: coinCards,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.lightBlue,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 30.0),
              alignment: Alignment.center,
              child:
                  Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
            ),
          ),
        ],
      ),
    );
  }
}
