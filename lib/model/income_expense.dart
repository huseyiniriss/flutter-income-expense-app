class IncomeExpense {
  int? id;
  String date;
  int? incomeExpenseType;
  double? amount;
  String? description;
  int? amountType;

  IncomeExpense(
      {this.id,
      required this.date,
      required this.incomeExpenseType,
      required this.amount,
      this.description,
      required this.amountType});

  IncomeExpense.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        incomeExpenseType = res["incomeExpenseType"],
        amount = res["amount"],
        date = res["date"],
        description = res["description"],
        amountType = res["amountType"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'date': date,
      'incomeExpenseType': incomeExpenseType,
      'amount': amount,
      'description': description,
      'amountType': amountType
    };
  }
}
