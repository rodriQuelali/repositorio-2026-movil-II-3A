/**
 * las clases abstractas, son clase que no se permiten
 * hacer instancias de ello
 * cuando utilizamos extends, solo metodos tenemos que implementar
 * cuando utilizamos implements, se implememta tod incluido propiedades y metodos
 * 
 * tambien se utiliza polimorfismo.
 */

void main(){
  // no se puede
  //Animales animal = new Animales();

  Gato gato1 = new Gato();
  Perro perro1 = new Perro();

  gato1.emitirSonido();
  perro1.emitirSonido();


}



//class adstract
abstract class Animal{
  late int patas;
  void emitirSonido();
}

class Perro implements Animal{
  late String raza;
  late int patas;

  @override
  void emitirSonido(){
    print("Ladraaaa....");
  }
}

class Gato extends Animal{
  late String color;

  @override
  void emitirSonido(){
    print("Maullarr....");
  }
  
}

//tarea ejemplo claro de  function Future en dart.putty