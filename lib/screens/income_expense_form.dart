import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:income_expense_flutter/model/income_expense.dart';
import 'package:income_expense_flutter/util/database_helper.dart';
import 'package:income_expense_flutter/widgets/date_button.dart';
import 'package:intl/intl.dart';

import '../util/constants.dart';

class IncomeExpenseForm extends StatefulWidget {
  const IncomeExpenseForm({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseForm> createState() => _IncomeExpenseFormState();
}

class _IncomeExpenseFormState extends State<IncomeExpenseForm> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime date = DateTime.now();
  int incomeExpenseType = Constants.incomeExpenseTypes[0]['value'];
  int amountType = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void onClickSave(String date, int incomeExpenseType, double amount,
      String description, int amountType) {
    DBHelper dbHelper = DBHelper();
    IncomeExpense incomeExpense = IncomeExpense(
        date: date,
        incomeExpenseType: incomeExpenseType,
        amount: amount,
        description: description,
        amountType: amountType);
    dbHelper.insertIncomeExpense(incomeExpense);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Expense Form'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Income Expense Type',
                    ),
                    icon: const Icon(Icons.shopping_bag_outlined),
                    items: Constants.incomeExpenseTypes.map((item) {
                      return DropdownMenuItem(
                        value: item['value'],
                        child: Text(item['label']),
                      );
                    }).toList(),
                    value: incomeExpenseType,
                    onChanged: (item) {
                      setState(() {
                        incomeExpenseType = item as int;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.attach_money_outlined),
                      labelText: 'Amount',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      contentPadding: EdgeInsets.all(4.0),
                    ),
                    maxLines: 5,
                    minLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: amountType,
                            onChanged: (value) {
                              setState(() {
                                amountType = value as int;
                              });
                            },
                          ),
                          const Text('Income')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: amountType,
                            onChanged: (value) {
                              setState(() {
                                amountType = value as int;
                              });
                            },
                          ),
                          const Text('Expense')
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (DateFormat('yyyy-MM-dd').format(date).isEmpty ||
                          incomeExpenseType.isNaN ||
                          amountController.text.isEmpty ||
                          amountType.isNaN) {
                        final snackBar = SnackBar(
                          content: const Text('Fill empty fields !'),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        String _date = DateFormat('yyyy-MM-dd').format(date);
                        double amount = double.parse(amountController.text);
                        String description = descriptionController.text;
                        onClickSave(_date, incomeExpenseType, amount,
                            description, amountType);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
