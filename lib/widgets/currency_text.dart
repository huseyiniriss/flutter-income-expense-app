import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final Future<String> currency;
  final TextStyle style;

  const CurrencyText(
      {Key? key, required this.currency, this.style = const TextStyle()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: currency,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Text(
            snapshot.data ?? '',
            style: style,
          );
        });
  }
}
