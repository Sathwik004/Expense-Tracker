import 'package:expense_tracker/Styling/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_class.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});

  final void Function(Expense expense) addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  Category _selectedCategory = Category.food;

  void _selectDate() async {
    var now = DateTime.now();
    final firstDate = DateTime(now.year, now.month - 2);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpense() {
    final enteredAmount = int.tryParse(_amountController.text);
    final invalidExpense = _titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0;
    if (invalidExpense) {
      showDialog(
          context: context,
          builder: (cxt) => AlertDialog(
                title: const Text('Invalid Expense'),
                content: const Text(
                    'Please make sure you have entered title and amount correclty!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(cxt);
                      },
                      child: const Text('OK'))
                ],
              ));
      return;
    }
    widget.addNewExpense(Expense(
        amount: enteredAmount,
        title: _titleController.text,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,16,16,keyboardSpace+16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 30,
                decoration: const InputDecoration(
                  label: CustomFont(data: 'Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: CustomFont(data:'Amount'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _selectDate,
                          icon: const Icon(Icons.date_range_rounded),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toString().toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (data) {
                        if (data == null) {
                          return;
                        }
                        setState(
                          () {
                            _selectedCategory = data;
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _saveExpense,
                      child: const Text('Save'), //add or save expense
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
