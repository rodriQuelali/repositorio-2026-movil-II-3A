void main(){

  var wolvewrin = new Heroe(nombre: "matar", poder: "poder");
  print(wolvewrin.toString());


}

class Heroe{
    String nombre;
    String poder;
    
    //constructor

    //antigua forma

 /* Heroe ({String nombre='sin nombre', String poder}){
     this.nombre = nombre;
     this.poder = poder;
   }*/
    
    Heroe({required this.nombre,required this.poder});

    //override 
    // es polimorfismo, se puede reemplazar el comportamiento de un metodo de la clase padre en la clase hija, en este caso el metodo toString() de la clase Object, que es la clase padre de todas las clases en Dart.
  @override
  String toString() {
    return 'Heroe: ---$nombre, Poder: $poder';
  }

}