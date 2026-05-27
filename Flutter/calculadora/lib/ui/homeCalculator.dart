//podemos llamar a statefull
//al staless
import 'package:calculadora/ui/pages/homePageCalculator.dart';
import 'package:flutter/material.dart';


class HomeCalculator extends StatelessWidget {
  const HomeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Flutter',
      home: HomePageCalculator(),
    );
  }
}