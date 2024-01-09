import 'package:expense_tracker/expenses_sf.dart';
import 'package:expense_tracker/widgets/analysis_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.isExpenseScreen});
  final bool isExpenseScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: const EdgeInsets.all(6),
        children: [
          ListTile(
            selected: isExpenseScreen,
            selectedTileColor:const Color.fromARGB(255, 50, 64, 92),
            selectedColor: Colors.white,
            onTap: isExpenseScreen
                ? null
                : () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Expenses(),
                    ));
                  },
            title: const Text('Expenses'),
          ),
          ListTile(
            selected: !isExpenseScreen,
            selectedTileColor: const Color.fromARGB(255, 50, 64, 92),
            selectedColor: Colors.white,
            onTap: isExpenseScreen
                ? () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AnalysisScreen(),
                    ));
                  }
                : null,
            title: const Text('Analysis'),
          ),
        ],
      ),
    );
  }
}
