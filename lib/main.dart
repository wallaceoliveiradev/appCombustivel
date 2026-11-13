import 'package:flutter/material.dart';

import 'calculadora.dart';

void main() => runApp(const AppCombustivel());

class AppCombustivel extends StatelessWidget {
  const AppCombustivel({super.key});

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF168447);
    return MaterialApp(
      title: 'Calculadora de Consumo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: verde),
        appBarTheme: const AppBarTheme(
          backgroundColor: verde,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7FAF7),
        useMaterial3: true,
      ),
      home: const CalculadoraPage(),
    );
  }
}
