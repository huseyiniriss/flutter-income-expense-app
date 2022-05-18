import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:income_expense_flutter/util/database_helper.dart';
import 'package:income_expense_flutter/widgets/date_button.dart';
import 'package:income_expense_flutter/widgets/monthy_row.dart';
import 'package:intl/intl.dart';

import '../model/daily_amount.dart';

Future<List<DailyAmount>> daysOfMontList(DateTime date) async {
  List<DailyAmount> dayList = [];
  DBHelper dbHelper = DBHelper();
  List<DailyAmount> incomeExpenseList =
      await dbHelper.getIncomeExpenseMonthly(DateFormat('MM').format(date));
  DateTime selectedDate = DateTime(date.year, date.month, 1);
  final maxDay = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

  for (var i = 1; i <= maxDay; i++) {
    String day = DateFormat('yyyy-MM-dd').format(selectedDate);
    var hasIncomeOrExpense =
        incomeExpenseList.where((element) => element.date == day);
    var income = 0;
    var expense = 0;
    if (hasIncomeOrExpense.isNotEmpty) {
      dayList.add(hasIncomeOrExpense.first);
    } else {
      dayList.add(DailyAmount(date: day, income: income, expense: expense));
    }
    selectedDate = selectedDate.add(const Duration(days: 1));
  }
  return dayList;
}

class MonthlyList extends StatefulWidget {
  final Future<String> currency;
  final bool reload;

  const MonthlyList({Key? key, required this.currency, required this.reload})
      : super(key: key);

  @override
  State<MonthlyList> createState() => _MonthlyListState();
}

class _MonthlyListState extends State<MonthlyList> {
  DateTime date = DateTime.now();
  late Future<List<DailyAmount>> days;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      days = daysOfMontList(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reload) {
      setState(() {
        days = daysOfMontList(date);
      });
    }
    return Column(
      children: [
        DateButton(
            date: date,
            dateFormat: 'yyyy MMMM',
            onTap: () async {
              var datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: date,
                dateFormat: "yyyy MMMM",
                locale: DateTimePickerLocale.en_us,
                looping: true,
              );
              setState(() {
                date = datePicked!;
                setState(() {
                  days = daysOfMontList(
                      DateTime(datePicked.year, datePicked.month, 1));
                });
              });
            }),
        FutureBuilder<List<DailyAmount>>(
            future: days,
            builder: (BuildContext context,
                AsyncSnapshot<List<DailyAmount>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return MonthlyRow(
                      amount: snapshot.data![index],
                      currency: widget.currency,
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
