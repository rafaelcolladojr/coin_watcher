import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 100.0,
          ),
          child: Text(
            '1 BTC = ? USD',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
