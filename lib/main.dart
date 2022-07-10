import 'package:currencydemo/currency_item.dart';
import 'package:currencydemo/providers/currency_provider.dart';
import 'package:currencydemo/screens/crypto_screen.dart';
import 'package:currencydemo/screens/fiat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrencyProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            titleMedium: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.yellow,
          scaffoldBackgroundColor: Color.fromARGB(117, 13, 0, 50),
        ),
        home: CryptoScreen(),
        routes: {
          CryptoScreen.routeName: (context) => CryptoScreen(),
          FiatScreen.routeName: (context) => FiatScreen(),
        },
      ),
    );
  }
}
