import 'package:flutter/material.dart';

class CoinCard extends StatefulWidget {
  CoinCard({
    Key? key,
    this.label,
  }) : super(key: key);

  String? label;
  State<CoinCard>? _state;

  @override
  State<CoinCard> createState() {
    _state = _CoinCardState();
    return _state!;
  }

  void updateLabel(String label) {
    _state!.setState(() {
      label = label;
    });
  }
}

class _CoinCardState extends State<CoinCard> {
  String? label;

  @override
  void initState() {
    super.initState();
    label = widget.label;
  }

  void updateStateLabel(String label) {
    setState(() {
      this.label = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            label.toString(),
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
