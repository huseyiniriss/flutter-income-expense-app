import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:income_expense_flutter/model/income_expense.dart';
import 'package:income_expense_flutter/widgets/currency_text.dart';
import 'package:income_expense_flutter/widgets/date_button.dart';
import 'package:intl/intl.dart';

import '../util/database_helper.dart';
import '../widgets/daily_row.dart';

Future<List<IncomeExpense>> dailyIncomeExpenseList(String date) async {
  DBHelper dbHelper = DBHelper();
  List<IncomeExpense> incomeExpenseList =
      await dbHelper.getIncomeExpenseDaily(date);
  return incomeExpenseList;
}

class DailyList extends StatefulWidget {
  final Future<String> currency;
  final bool reload;

  const DailyList({Key? key, required this.currency, required this.reload})
      : super(key: key);

  @override
  State<DailyList> createState() => _DailyListState();
}

class _DailyListState extends State<DailyList> {
  DateTime date = DateTime.now();
  late Future<List<IncomeExpense>> dailyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      dailyList = dailyIncomeExpenseList(DateFormat('yyyy-MM-dd').format(date));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reload) {
      setState(() {
        dailyList =
            dailyIncomeExpenseList(DateFormat('yyyy-MM-dd').format(date));
      });
    }
    return Column(
      children: [
        DateButton(
            date: date,
            dateFormat: 'yyyy MM EEEE',
            onTap: () async {
              var datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: date,
                dateFormat: "yyyy MM dd",
                locale: DateTimePickerLocale.en_us,
                looping: true,
              );
              setState(() {
                date = datePicked!;
                dailyList = dailyIncomeExpenseList(
                    DateFormat('yyyy-MM-dd').format(date));
              });
            }),
        FutureBuilder<List<IncomeExpense>>(
            future: dailyList,
            builder: (BuildContext context,
                AsyncSnapshot<List<IncomeExpense>> snapshot) {
              if (snapshot.hasData) {
                double incomeTotal = 0;
                double expenseTotal = 0;
                snapshot.data?.forEach((element) {
                  if (element.amountType == 0) {
                    incomeTotal += element.amount!;
                  } else {
                    expenseTotal += element.amount!;
                  }
                });
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(children: [
                        const Text(
                          'Total',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text((incomeTotal - expenseTotal).toString(),
                                style: const TextStyle(fontSize: 20.0)),
                            CurrencyText(currency: widget.currency)
                          ],
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          const Text(
                            'Income',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 16.0),
                          ),
                          Row(
                            children: [
                              Text(incomeTotal.toString(),
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 16.0)),
                              CurrencyText(
                                  currency: widget.currency,
                                  style: const TextStyle(color: Colors.green))
                            ],
                          ),
                        ]),
                        Column(children: [
                          const Text(
                            'Expense',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 16.0),
                          ),
                          Row(
                            children: [
                              Text(expenseTotal.toString(),
                                  style: const TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0)),
                              CurrencyText(
                                  currency: widget.currency,
                                  style:
                                      const TextStyle(color: Colors.redAccent))
                            ],
                          ),
                        ])
                      ],
                    ),
                  ],
                );
              }
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }),
        const Divider(height: 10),
        FutureBuilder<List<IncomeExpense>>(
            future: dailyList,
            builder: (BuildContext context,
                AsyncSnapshot<List<IncomeExpense>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text('There is no item')),
                  );
                }
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return DailyRow(
                      incomeExpense: snapshot.data![index],
                      currency: widget.currency,
                      onDelete: () async {
                        if (await confirm(context,
                            title: const Text('Confirm delete'),
                            content:
                                const Text('Are you sure delete item ?'))) {
                          DBHelper dbHelper = DBHelper();
                          dbHelper
                              .delete(snapshot.data![index].id)
                              .then((value) => {
                                    if (value == 1)
                                      {
                                        setState(() {
                                          dailyList = dailyIncomeExpenseList(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(date));
                                        })
                                      }
                                  });
                        }
                      },
                    );
                  },
                ));
              }
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }),
      ],
    );
  }
}
