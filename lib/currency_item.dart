import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CurrencyItem extends StatelessWidget {
  final String symbol;
  final String title;
  final String rate;

  const CurrencyItem({
    super.key,
    required this.symbol,
    required this.title,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 118, 107, 12),
          Color.fromARGB(255, 47, 43, 43),
        ]),
      ),
      child: ListTile(
        title: Text(
          symbol,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(title),
        trailing: Text(
          rate,
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ),
    );
  }
}
