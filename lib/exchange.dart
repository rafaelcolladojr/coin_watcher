import 'dart:convert';

import 'package:http/http.dart' as http;

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '23AACD27-E0E7-4EF7-95FB-9B9D9AD229EB';

class ExchangeHandler {
  var client;

  ExchangeHandler() {
    client = http.Client();
  }

  Future<dynamic> getExchangeRateInfo(String coin, String currency) async {
    http.Response response = await client.get(
      Uri.parse('$baseURL/$coin/$currency'),
      headers: {'X-CoinAPI-Key': apiKey},
    );

    var result = jsonDecode(response.body);

    return result;
  }
}
