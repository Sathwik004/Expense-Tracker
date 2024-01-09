import 'package:expense_tracker/data/expenses_list.dart';
import 'package:expense_tracker/models/expense_class.dart';
import 'package:expense_tracker/models/expense_list.dart';
import 'package:expense_tracker/widgets/drawer.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/material.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'expenses.db'),
    onCreate: (db, version) async => await db.execute(
        'CREATE TABLE expense_list(id TEXT PRIMARY KEY, title TEXT, amount INTEGER, datetime TEXT, category TEXT)'),
    version: 1,
  );
  final data = await db.query('expense_list');
  print('getting');
  print(data.toString());
  return db;
}

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  void _addExpense(Expense expense) async {
    final db = await _getDatabase();
    db.insert('expense_list', {
      'id': expense.id,
      'title': expense.title,
      'amount': expense.amount,
      'datetime': expense.date.toString(),
      'category': expense.category.toString(),
    }).then(
      (value) {
        setState(() {
          expensesList.add(expense);
        });
      },
    );
    db.close();
  }

  void _loadExpenses() async {
    final db = await _getDatabase();
    print('got');
    final data = await db.query('expense_list');
    setState(() {
      expensesList.addAll(data
          .map((row) => Expense(
              amount: row['amount'] as int,
              title: row['title'] as String,
              date: DateTime.tryParse(row['datetime'] as String) ??
                  DateTime.now(),
              category: categordecode(row['category'] as String),
              id: row['id'] as String))
          .toList());
    });

    db.close();
  }

  void _newExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => NewExpense(
              addNewExpense: _addExpense,
            ));
  }

  void _removeExpense(Expense expense) async {
    final int expenseIndex = expensesList.indexOf(expense);
    final db = await _getDatabase();
    print(expense.id);
    final b = await db
        .delete('expense_list', where: 'id = ?', whereArgs: [expense.id]);
    print(b.toString());
    final data = await db.query('expense_list');
    print(data.toString());
    db.close();

    setState(() {
      expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense removed'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expensesList.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainExpenseContent = const CircularProgressIndicator();

    if (expensesList.isNotEmpty) {
      mainExpenseContent = ExpensesList(
        expenses: expensesList,
        removeExpense: _removeExpense,
      );
    } else {
      mainExpenseContent = const Text(
        'No Expenses!',
        style: TextStyle(fontSize: 28),
      );
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: _newExpenseOverlay, icon: const Icon(Icons.add)),
          ],
          title: const Text('My Expense Tracker'),
        ),
        drawer: const MyDrawer(isExpenseScreen: true),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: mainExpenseContent,
          ),
        ));
  }
}
