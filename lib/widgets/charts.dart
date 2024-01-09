import 'package:expense_tracker/Styling/custom_font.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_class.dart';
//import 'package:expense_tracker/Styling/custom_font.dart';

class Charts extends StatelessWidget {
  const Charts({super.key, required this.expenses});

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, category: Category.travel),
      ExpenseBucket.forCategory(expenses, category: Category.food),
      ExpenseBucket.forCategory(expenses, category: Category.supplies),
      ExpenseBucket.forCategory(expenses, category: Category.lesiure)
    ];
  }

  double get maxExpense {
    double maxExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalCategoryExpense > maxExpense) {
        maxExpense = bucket.totalCategoryExpense;
      }
    }
    return maxExpense;
  }

  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
            Theme.of(context).colorScheme.secondary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets
                  .map((bucket) => ChartBarVertical(
                      fill: bucket.totalCategoryExpense == 0
                          ? 0
                          : bucket.totalCategoryExpense / maxExpense))
                  .toList(),
            ),
          ),
          //const SizedBox(height: 8),
          SizedBox(
            height: 20,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
              child: Row(
                children: buckets
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[bucket.category],
                            color: isDarkTheme
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withOpacity(0.85)
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BudgetChart extends StatelessWidget {
  const BudgetChart({super.key, required this.expenses, this.budget = 2000});
  final List<Expense> expenses;

  int get totalExpense {
    int total = 0;
    for (final expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  final int budget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomFont(
                data: '₹$totalExpense /$budget',
                size: 18,
                fweight: FontWeight.bold,
              ),
              //SetBudget(budget: budget,),
            ],
          ),
          ChartBarHorizontal(
              fill: totalExpense > budget ? 1 : totalExpense / budget),
        ],
      ),
    );
  }
}
// Adding a Button instead of text which enablees us to change Budget
// Still Working on it
/*class SetBudget extends StatefulWidget{
  SetBudget({super.key, this.budget=2000});
  int budget;
  @override
  State<SetBudget> createState() {
    return _SetBudget();
  }
}

class _SetBudget extends State<SetBudget>{

  //final Function() setBudget;
  final _budgetController = TextEditingController();

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  void _saveBudget(){
    setState(() {
      widget.budget = _budgetController.text as int;
    });
    print(widget.budget);
  }
  void _changeBudget(){
    showModalBottomSheet(context: context, builder: ((context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(child: Row(
          children: [
            TextField(controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: CustomFont(data: 'Budget',),),),
            ElevatedButton(onPressed: _saveBudget, child: const Text('Save'))
          ],
        )),
      );
    }));
  }
  
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _changeBudget, child: Text('$widget.budget'));
  }
}*/