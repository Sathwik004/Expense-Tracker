import 'package:expense_tracker/data/database.dart';
import 'package:expense_tracker/data/expenses_list.dart';
import 'package:expense_tracker/models/expense_class.dart';
import 'package:expense_tracker/models/expense_list.dart';
import 'package:expense_tracker/widgets/drawer.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  void _newExpenseOverlay() async {
    final expense = await showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => const NewExpense(
              addNewExpense: addExpense,
            ));
    setState(() {
      expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) async {
    final int expenseIndex = expensesList.indexOf(expense);
    setState(() {
      expensesList.remove(expense);
    });
    removeExpense(expenseIndex, expense.id);

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
            addExpense(expense);
          }),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (expensesList.isEmpty) {
        loadExpenses().then((value) => setState(() => expensesList.addAll(value),) ); //If list is empty checking db and trying to load list
    }
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
        ),);
  }
}
