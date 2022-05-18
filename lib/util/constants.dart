import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const List incomeExpenseTypes = [
    {'value': 1, 'label': 'Market'},
    {'value': 2, 'label': 'Food, Drink'},
    {'value': 3, 'label': 'Health, Personal Care'},
    {'value': 4, 'label': 'Entertainment, Hobbies'},
    {'value': 5, 'label': 'Education'},
    {'value': 6, 'label': 'Home'},
    {'value': 7, 'label': 'Travel, Trip'},
    {'value': 8, 'label': 'Clothing, Accessories'},
    {'value': 9, 'label': 'Insurance, Tax, Credit'},
    {'value': 10, 'label': 'Automobile, Fuel, Transportation'},
    {'value': 11, 'label': 'Invoice'},
    {'value': 12, 'label': 'Child'},
    {'value': 13, 'label': 'Other'},
  ];

  static const Map currencies = {
    'TRY': '₺',
    'USD': '\$',
    'EURO': '€',
    'GBP': '£'
  };

  static setCurrency(_currency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currency', _currency);
  }

  static Future<String> getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return currencies[prefs.getString('currency') ?? 'TRY'];
  }
}
