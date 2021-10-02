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

  Widget getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      children: [
        for (String item in constants.currency) Text(item),
      ],
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = constants.currency[index];
        });
      },
    );
  }

  Widget getDropDownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: [
        for (String item in constants.currency)
          DropdownMenuItem(child: Text(item), value: item),
      ],
      onChanged: (value) {
        setState(() {
          selectedCurrency = value ?? 'USD ';
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    printExchangeRate();
  }

  void printExchangeRate() async {
    var result = await exchangeHandler.getExchangeRateInfo('BTC', 'USD');
    print(result);
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
              children: const [
                CoinCard(),
              ],
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
