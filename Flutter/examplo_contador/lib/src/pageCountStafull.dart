import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//ordenar codigo ctrl +alt + p

class _MyHomePageState extends State<MyHomePage> {
  int _contador = 0;

  void _incremeto(){
    // setState , es un metodo que se encarga de actualizar la interfaz de usuario cada vez que se llama a este metodo, es decir, cada vez que se llama a este metodo, se vuelve a construir la interfaz de usuario con los nuevos datos.
    setState(() {
      _contador++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contador", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(1, 18, 137, 100),
      ),
      body:ListView(
        children: [
          titulo(),
          disenoContador(),
        ],
      ), 
      
      floatingActionButton: FloatingActionButton(
        onPressed: _incremeto,
        child: Icon(Icons.add),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incremeto,
        child: Icon(Icons.remove),
      ),*/
    );
  }


//titulo de la aplicacion
  Widget titulo(){
    return Text("TITULO DE LA APLICACION", textAlign: TextAlign.center);
  }

  //cuerpo de la aplicaion
  Widget disenoContador(){
    return Center(
      child: Container(
        width: 300,
        height: 200,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 152, 122),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(66, 235, 8, 8),
                blurRadius: 30,
                offset: Offset(4, 6),
              ),
            ],
          ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text("Contador:", 
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0
              )
            ),
            Text("$_contador", style: TextStyle(fontSize: 20),)
          ],
        )
      ),
    );
  }
}
