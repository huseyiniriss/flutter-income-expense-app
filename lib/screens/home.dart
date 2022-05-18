import 'dart:async';

import 'package:flutter/material.dart';
import 'package:income_expense_flutter/screens/montly_list.dart';
import 'package:income_expense_flutter/util/router.dart';

import '../util/constants.dart';
import '../widgets/currency_menu.dart';
import '../widgets/custom_bottom_navigationBar.dart';
import 'daily_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPageIndex = 0;
  var titles = ['Monthly', 'Daily'];
  bool reload = false;
  Future<String> currency = Constants.getCurrency();

  void _onTap(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if (reload) {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          reload = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedPageIndex]), actions: [
        CurrencyMenu(
          currency: currency,
          onSelected: (value) {
            setState(() {
              Constants.setCurrency(value.toString());
              currency = Constants.getCurrency();
            });
          },
        )
      ]),
      body: Center(
        child: selectedPageIndex == 0
            ? MonthlyList(
                currency: currency,
                reload: reload,
              )
            : DailyList(currency: currency, reload: reload),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(onTap: _onTap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.incomeExpenseForm)
              .then((value) => {
                    setState(() {
                      reload = true;
                    })
                  });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
