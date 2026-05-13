
import 'package:flutter/material.dart';
import 'package:flutter_application_1/examploInIA.dart';

void main(){
  runApp(MyApp2());
}

class MyApp extends StatelessWidget{

  //StatelessWidget: Sin estado, no cambios.

  // build: Construye la interfaz de usuario.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //pagian principal
      home: Scaffold(
        //barra superior
        appBar: AppBar(
          title: Text("Mi primera aplicacion"),
        ),
        //conetido principal de la pantalla
        body: Column(
          children: [
            Text("hola"),
            TextButton(
              onPressed: ()=>{}, 
              child: Text("nombre")
            ),
          ],
        ),
        
        //barra de navegacion inferior.
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_alert_rounded),
              label: "Inicio"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Ajustes"
            ),
          ]
        ),
        //Boton flotante
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{},
          child: Icon(Icons.access_alarm_outlined),
        ),

        //el menu lateral deslizable
        drawer: Drawer(
          //lista de widget
          child: ListView(
            children: [
              ListTile(
                title: Text("Usuario"),
                onTap: ()=>{},
              ),
              ListTile(
                title: Text("Configuracion"),
                onTap: ()=>{},
              )
            ],
          ),
        ),
      ),
    );
  }

  int suma(){
    return 0;
  }

}

class MyHomeApp extends StatelessWidget {
  const MyHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}