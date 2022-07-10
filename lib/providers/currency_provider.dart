import 'dart:convert';

import 'package:currencydemo/providers/currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyProvider with ChangeNotifier {
  List<Currency> _currencies = [
    /* Currency(
      symbol: 'BTC',
      title: 'Bitcoin',
      rate: 21507.0,
    ) */
  ];

  List<Currency> get currencies {
    return [..._currencies];
  }

  Future<void> fetchCurrencies() async {
    final url = Uri.parse('http://api.coincap.io/v2/rates/');
    final response = await http.get(url);
    final responseBody = json.decode(response.body);
    final fetchedCurrencies = responseBody['data'] as List<dynamic>;
    _currencies.clear();

    for (var i = 0; i < fetchedCurrencies.length; i++) {
      final currentSymbol = fetchedCurrencies[i]['symbol'];
      if (currentSymbol == 'TRY' ||
          currentSymbol == 'EUR' ||
          currentSymbol == 'BTC' ||
          currentSymbol == 'LTC') {
        _currencies.add(
          Currency(
            symbol: fetchedCurrencies[i]['symbol'],
            title: fetchedCurrencies[i]['id'],
            rate: fetchedCurrencies[i]['rateUsd'],
          ),
        );
      }
    }

    notifyListeners();
  }

  Future<void> fetchFIAT() async {
    final url = Uri.parse('http://api.coincap.io/v2/rates/');
    final response = await http.get(url);
    final responseBody = json.decode(response.body);
    final fetchedCurrencies = responseBody['data'] as List<dynamic>;
    _currencies.clear();

    for (var i = 0; i < fetchedCurrencies.length; i++) {
      final currentType = fetchedCurrencies[i]['type'];
      if (currentType == 'fiat') {
        _currencies.add(
          Currency(
            symbol: fetchedCurrencies[i]['symbol'],
            title: fetchedCurrencies[i]['id'],
            rate: fetchedCurrencies[i]['rateUsd'],
          ),
        );
      }
    }

    notifyListeners();
  }

  Future<void> updateRates() async {
    final url = Uri.parse('http://api.coincap.io/v2/rates/');
    var rateUsd;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final fetchedCurrencies = responseBody['data'] as List<dynamic>;
      for (int i = 0; i < _currencies.length; i++) {
        rateUsd = _currencies[i].rate;
        for (int j = 0; j < fetchedCurrencies.length; j++) {
          if (_currencies[i].title == fetchedCurrencies[j]['id']) {
            rateUsd = fetchedCurrencies[j]['rateUsd'];
            _currencies[i].rate = rateUsd;
          }
        }
      }

      for (var i = 0; i < _currencies.length; i++) {
        final currencyMatch = fetchedCurrencies.forEach((element) {
          if (element['id'] == _currencies[i].title) ;
        });
      }

      notifyListeners();
    }
  }

  Future<void> findIdBySymbol(String symbol) async {
    final url = Uri.parse('http://api.coincap.io/v2/rates/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final currencies = responseBody['data'] as List<dynamic>;
      final symbolIndex = currencies.indexWhere((element) => element['symbol']);
    }
  }

  Future<void> getCurrency(String currencyTitle) async {
    final url = Uri.parse('http://api.coincap.io/v2/rates/$currencyTitle');
    final response = await http.get(url);
    final List<Currency> newCurrencyList = [];
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final selectedCurrency = responseBody['data'];

      newCurrencyList.add(
        Currency(
          symbol: selectedCurrency['symbol'],
          title: selectedCurrency['id'],
          rate: selectedCurrency['rateUsd'],
        ),
      );

      _currencies = newCurrencyList;
      notifyListeners();
    }
  }
}
