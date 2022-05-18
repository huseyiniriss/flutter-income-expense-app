import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/income_expense_form.dart';

class Routes {
  static const String homeScreen = '/';
  static const String incomeExpenseForm = '/incomeExpenseForm';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.incomeExpenseForm:
        return MaterialPageRoute(builder: (_) => const IncomeExpenseForm());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
