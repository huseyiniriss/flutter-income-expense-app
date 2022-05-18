import 'package:flutter/material.dart';
import 'package:income_expense_flutter/model/income_expense.dart';
import 'package:income_expense_flutter/util/constants.dart';
import 'package:income_expense_flutter/widgets/currency_text.dart';

class DailyRow extends StatelessWidget {
  final Future<String> currency;
  final IncomeExpense incomeExpense;
  final dynamic onDelete;

  const DailyRow(
      {Key? key,
      required this.currency,
      required this.incomeExpense,
      this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: onDelete,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      incomeExpense.amount.toString(),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    CurrencyText(currency: currency)
                  ],
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(35.0)),
                  border: Border.all(
                    color: incomeExpense.amountType == 0
                        ? Colors.green
                        : Colors.redAccent,
                    width: 1.5,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(incomeExpense.description.toString().isNotEmpty
                        ? incomeExpense.description.toString()
                        : 'No description'),
                    Text(
                      Constants.incomeExpenseTypes
                          .where((element) =>
                              element['value'] ==
                              incomeExpense.incomeExpenseType)
                          .first['label'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black54),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
