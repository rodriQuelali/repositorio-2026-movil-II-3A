
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget{

  //StatelessWidget: Sin estado, no cambios.

  // build: Construye la interfaz de usuario.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Text("Hola 3ro A"),
    );
  }
}

class MyHomeApp extends StatelessWidget {
  const MyHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}