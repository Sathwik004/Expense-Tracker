// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, supplies, lesiure }

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.dining_rounded,
  Category.travel: Icons.tram_rounded,
  Category.supplies: Icons.school_rounded,
  Category.lesiure: Icons.movie_creation_outlined
};

Category categordecode(String s)
{
  return Category.values.firstWhere((element) => s == element.toString());
}

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category,
      String? id})
      : id = id ?? uuid.v4();

  final String id;
  final DateTime date;
  final int amount;
  final String title;
  final Category category;

  get formattedDate {
    return (formatter.format(date));
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, {required this.category})
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  Category category;
  final List<Expense> expenses;

  double get totalCategoryExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

class Budget {
  Budget({required this.allExpenses});

  final List<Expense> allExpenses;

  double get finalTotalExpense{

    double total=0;
    for(final expense in allExpenses){
      total += expense.amount;
    }

    return total;
  }

}
