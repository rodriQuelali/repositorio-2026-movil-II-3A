import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contador", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(1, 18, 137, 100),
      ),
      body: Text("Nombre..."),
    );
  }
}
