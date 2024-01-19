import 'package:expense_tracker/data/expenses_list.dart';
import 'package:expense_tracker/models/expense_class.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'expenses.db'),
    onCreate: (db, version) async => await db.execute(
        'CREATE TABLE expense_list(id TEXT PRIMARY KEY, title TEXT, amount INTEGER, datetime TEXT, category TEXT)'),
    version: 1,
  );
  return db;
}

void addExpense(Expense expense) async {
    final db = await getDatabase();
    await db.insert('expense_list', {
      'id': expense.id,
      'title': expense.title,
      'amount': expense.amount,
      'datetime': expense.date.toString(),
      'category': expense.category.toString(),
    }).then(
      (value) {
          expensesList.add(expense);
        
      },
    );
    db.close();
  }

  Future<List<Expense>> loadExpenses() async {
    final db = await getDatabase();
    final data = await db.query('expense_list');
      final list = data
          .map((row) => Expense(
              amount: row['amount'] as int,
              title: row['title'] as String,
              date: DateTime.tryParse(row['datetime'] as String) ??
                  DateTime.now(),
              category: categordecode(row['category'] as String),
              id: row['id'] as String))
          .toList();

    db.close();
    return list;
  }

  void removeExpense(expenseIndex, id) async
  {
    final db = await getDatabase();
    await db
        .delete('expense_list', where: 'id = ?', whereArgs: [id]);
    db.close();
  }