import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../currency_item.dart';
import '../custom_search.dart';
import '../providers/currency_provider.dart';

class CryptoScreen extends StatefulWidget {
  static const routeName = '/crypto';
  const CryptoScreen({
    super.key,
  });

  @override
  State<CryptoScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CryptoScreen> {
  var _currentIndex = 0;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<CurrencyProvider>(context).fetchCurrencies().then(
            (value) => setState(() {
              _isLoading = false;
            }),
          );
    }
    Provider.of<CurrencyProvider>(context, listen: false).updateRates();
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final currencyData = Provider.of<CurrencyProvider>(context);
    final _currencyInputController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomSearch(
                        currencyInputController: _currencyInputController,
                        currencyData: currencyData);
                  });
            },
            icon: const Icon(Icons.search),
          )
        ],
        foregroundColor: Theme.of(context).textTheme.titleMedium!.color,
        backgroundColor: Color.fromARGB(255, 118, 107, 12),
        title: Text('Currencies'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color.fromARGB(117, 13, 0, 50),
        selectedItemColor: Color.fromARGB(186, 255, 235, 59),
        items: [
          BottomNavigationBarItem(
            label: 'Crypto',
            icon: Icon(Icons.auto_graph),
          ),
          BottomNavigationBarItem(
            label: 'FIAT',
            icon: Icon(Icons.attach_money_sharp),
          ),
        ],
        onTap: ((value) {
          _currentIndex = value;
          if (_currentIndex == 0) {
            Provider.of<CurrencyProvider>(context, listen: false)
                .fetchCurrencies();
          }
          if (_currentIndex == 1) {
            Provider.of<CurrencyProvider>(context, listen: false).fetchFIAT();
          }
        }),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.yellow,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.only(top: 10),
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                final splitIndex =
                    currencyData.currencies[index].rate.indexOf('.') + 4;
                final rateStr = currencyData.currencies[index].rate
                    .substring(0, splitIndex);
                return CurrencyItem(
                  symbol: currencyData.currencies[index].symbol,
                  title: currencyData.currencies[index].title,
                  rate: '\$' + rateStr,
                );
              },
              itemCount: currencyData.currencies.length,
            ),
    );
  }
}
