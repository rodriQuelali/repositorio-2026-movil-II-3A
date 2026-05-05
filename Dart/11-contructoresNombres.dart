import 'dart:convert';
void main(){

  //api me devuleve en formato JSON
  final jsonString = '{"nombre": "spider man 2", "poder": "trepar paredes"}';

  Map parsedJson = jsonDecode(jsonString);
  //jsonDecode
  //jsonEncode

  final  heroe1 = Heroe.fromJson(parsedJson);
  print(heroe1.nombre);


}

class Heroe{
    String? nombre;
    String? poder;
    
    //constructor
    Heroe(this.nombre, this.poder); 

    //parcear los datos y mandar al contructor
    Heroe.fromJson(Map parsedJson){
      nombre = parsedJson['nombre'];
      poder = parsedJson['poder'];
    }



}