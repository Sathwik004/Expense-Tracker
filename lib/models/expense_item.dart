import 'package:expense_tracker/Styling/custom_font.dart';
import 'package:flutter/material.dart';
import 'expense_class.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                CustomFont(
                  data: 'Cost ₹${expense.amount}',
                ),
                const Spacer(),
                Icon(categoryIcons[expense.category]),
                const SizedBox(
                  width: 5,
                ),
                CustomFont(data: expense.formattedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
