import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses_sf.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 63, 255, 140));
var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 48, 58, 75));
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Expense Tracker',
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
            foregroundColor: kDarkColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: kDarkColorScheme.onSecondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
          textTheme: ThemeData.dark().textTheme.copyWith(
                titleLarge: TextStyle(
                  color: kDarkColorScheme.onSecondaryContainer,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                labelLarge: TextStyle(color: kDarkColorScheme.onSecondaryContainer)
              ),
            bottomSheetTheme: const BottomSheetThemeData().copyWith(
              //backgroundColor: kDarkColorScheme.onPrimaryContainer,
              modalBackgroundColor: kDarkColorScheme.onSecondaryContainer,
            )
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.onSecondaryContainer,
                foregroundColor: kColorScheme.secondaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  color: kColorScheme.secondaryContainer,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        themeMode: ThemeMode.system,
        home: const Expenses());
  }
}
