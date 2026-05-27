
import 'package:flutter/material.dart';


class HomePageCalculator extends StatefulWidget {
  const HomePageCalculator({super.key});

  @override
  State<HomePageCalculator> createState() => _HomePageCalculatorState();
}

class _HomePageCalculatorState extends State<HomePageCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
        backgroundColor: Colors.blueAccent,
      ),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Numero 1:"),
            TextField(), //TextField, las cajas de texto,
            Text("Numero 2"),
            TextField()
          ],
        )
      ),
    );
  }
}