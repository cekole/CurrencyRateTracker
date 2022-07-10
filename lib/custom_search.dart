import 'package:flutter/material.dart';

import 'providers/currency_provider.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required TextEditingController currencyInputController,
    required this.currencyData,
  })  : _currencyInputController = currencyInputController,
        super(key: key);

  final TextEditingController _currencyInputController;
  final CurrencyProvider currencyData;

  @override
  Widget build(BuildContext context) {
    var _isSearched = true;
    return Center(
      child: Card(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.65),
        color: Color.fromARGB(255, 118, 107, 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _currencyInputController,
            decoration: InputDecoration(
              labelText: 'Enter Currency',
            ),
            onSubmitted: (value) {
              if (_isSearched) {
                currencyData.getCurrency(_currencyInputController.text);
                _isSearched = false;
              }
              //currencyData.fetchCurrencies();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
