import 'package:flutter/material.dart';
import 'package:income_expense_flutter/model/daily_amount.dart';

import 'currency_text.dart';

Color dayCardInfoColor(DailyAmount amount) {
  if (amount.income > amount.expense) {
    return Colors.green;
  } else if (amount.income < amount.expense) {
    return Colors.redAccent;
  }
  return Colors.grey;
}

class MonthlyRow extends StatelessWidget {
  final DailyAmount amount;
  final Future<String> currency;

  const MonthlyRow({Key? key, required this.amount, required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () {
          final snackBar = SnackBar(
            content: Text(amount.date),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Row(
          children: [
            Container(
                height: 60,
                width: 6,
                decoration: BoxDecoration(
                  color: dayCardInfoColor(amount),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  amount.date,
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Income',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          amount.getIncome(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        CurrencyText(
                          currency: currency,
                          style: const TextStyle(fontSize: 12.0),
                        )
                      ],
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Expense',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          amount.getExpense(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        CurrencyText(
                          currency: currency,
                          style: const TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          amount.getTotal(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: dayCardInfoColor(amount)),
                          textAlign: TextAlign.center,
                        ),
                        CurrencyText(
                            currency: currency,
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                color: dayCardInfoColor(amount)))
                      ],
                    )
                  ],
                )),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              iconSize: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
