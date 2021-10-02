import 'dart:convert';

import 'package:http/http.dart' as http;

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = ''; //TODO: add API key

class ExchangeHandler {
  dynamic client;

  ExchangeHandler() {
    client = http.Client();
  }

  Future<dynamic> getExchangeRateInfo(String currency) async {
    http.Response response = await client.get(
      Uri.parse('$baseURL/$currency'),
      headers: {'X-CoinAPI-Key': apiKey},
    );

    var result = jsonDecode(response.body);

    return result;
  }
}
