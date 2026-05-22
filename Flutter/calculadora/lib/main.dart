
import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
	

  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();

  String resultado = "";

  void calcular(String operacion) {
    double? num1 = double.tryParse(num1Controller.text);
    double? num2 = double.tryParse(num2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        resultado = "Ingresa números válidos";
      });
      return;
    }

    double res;

    switch (operacion) {
      case '+':
        res = num1 + num2;
        break;
      case '-':
        res = num1 - num2;
        break;
      case '*':
        res = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          resultado = "División por cero";
          setState(() {});
          return;
        }
        res = num1 / num2;
        break;
      default:
        res = 0;
    }

    setState(() {
      resultado = "Resultado: $res";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculadora Flutter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 1'),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 2'),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => calcular('+'),
                  child: Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => calcular('-'),
                  child: Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => calcular('*'),
                  child: Text('×'),
                ),
                ElevatedButton(
                  onPressed: () => calcular('/'),
                  child: Text('÷'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              resultado,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

