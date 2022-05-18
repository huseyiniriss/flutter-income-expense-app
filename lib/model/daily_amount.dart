class DailyAmount {
  String date;
  dynamic income;
  dynamic expense;

  DailyAmount(
      {required this.date, required this.income, required this.expense});

  DailyAmount.fromMap(Map<String, dynamic> res)
      : date = res["date"],
        income = res["income"],
        expense = res["expense"];

  String getTotal() => (income - expense).toString();

  String getIncome() => income.toString();

  String getExpense() => expense.toString();
}
