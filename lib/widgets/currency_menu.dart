import 'package:flutter/material.dart';

import '../util/constants.dart';
import 'currency_text.dart';

class CurrencyMenu extends StatelessWidget {
  final Future<String> currency;
  final PopupMenuItemSelected onSelected;

  const CurrencyMenu(
      {Key? key, required this.currency, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: PopupMenuButton(
            child: Center(
              child: CurrencyText(
                currency: currency,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
            ),
            itemBuilder: (context) {
              return Constants.currencies.keys.map((item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text('$item ${Constants.currencies[item]}'),
                );
              }).toList();
            },
            onSelected: onSelected));
  }
}
