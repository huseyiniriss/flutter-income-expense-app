import 'package:income_expense_flutter/model/daily_amount.dart';
import 'package:income_expense_flutter/model/income_expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final String dbName = "income_expense.db";
  final String tableName = "incomeexpenselist";

  Future<Database> initializeDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);
    var database = await openDatabase(path, version: 1, onCreate: onCreate);
    return database;
  }

  void onCreate(Database database, int version) async {
    await database.execute("DROP TABLE IF EXISTS $tableName");
    await database.execute('''
            CREATE TABLE $tableName (
            id                INTEGER PRIMARY KEY AUTOINCREMENT,
            date              TEXT,
            incomeExpenseType INTEGER,
            amount            REAL,
            description       TEXT,
            amountType        INTEGER
        )''');
  }

  Future<IncomeExpense> insertIncomeExpense(IncomeExpense incomeExpense) async {
    final Database db = await initializeDB();
    incomeExpense.id = await db.insert(tableName, incomeExpense.toMap());
    return incomeExpense;
  }

  Future<List<DailyAmount>> getIncomeExpenseMonthly(String month) async {
    final Database db = await initializeDB();
    List<Map<String, Object?>> queryResult = await db.rawQuery('''SELECT L.date,
        SUM(CASE WHEN L.amountType = 0 THEN amount ELSE 0 END) income,
    SUM(CASE WHEN L.amountType = 1 THEN amount ELSE 0 END) expense
    FROM $tableName L
    WHERE STRFTIME('%m', DATE(L.date) ) = ?
    GROUP BY L.date''', [month]);
    return queryResult.map((e) => DailyAmount.fromMap(e)).toList();
  }

  Future<List<IncomeExpense>> getIncomeExpenseDaily(String date) async {
    final Database db = await initializeDB();
    List<Map<String, Object?>> queryResult = await db
        .rawQuery('SELECT * FROM $tableName L WHERE L.date = ?', [date]);
    return queryResult.map((e) => IncomeExpense.fromMap(e)).toList();
  }

  Future<int> delete(dynamic id) async {
    final Database db = await initializeDB();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(IncomeExpense incomeExpense) async {
    final Database db = await initializeDB();
    return await db.update(tableName, incomeExpense.toMap(),
        where: 'id = ?', whereArgs: [incomeExpense.id]);
  }
}
