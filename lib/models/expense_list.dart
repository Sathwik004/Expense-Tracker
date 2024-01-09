import 'package:expense_tracker/models/expense_class.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    final expensesLen = expenses.length - 1;
    return (ListView.builder(
        itemCount: expensesLen + 1,
        itemBuilder: (context, index) {
          final reversedIndex = expensesLen - index;
          return Dismissible(
            key: ValueKey(expenses[reversedIndex]),
            onDismissed: (direction) => removeExpense(expenses[reversedIndex]),
            child: ExpenseItem(expenses[reversedIndex]),
          );
        }));
  }
}
