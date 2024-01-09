import 'package:expense_tracker/data/expenses_list.dart';
import 'package:expense_tracker/widgets/charts.dart';
import 'package:expense_tracker/widgets/drawer.dart';
import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis'),
      ),
      drawer: const MyDrawer(isExpenseScreen: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BudgetChart(expenses: expensesList,),
            Charts(expenses: expensesList),
          ],
        ),
      ),
    );
  }
}
