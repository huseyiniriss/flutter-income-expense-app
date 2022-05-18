import 'package:flutter/material.dart';
import 'package:income_expense_flutter/screens/home.dart';
import 'package:income_expense_flutter/util/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Income Expense App With Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Home(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
