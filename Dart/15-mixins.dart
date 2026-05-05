void main(){
  final gato1 = new Gato();
  gato1.caminar();
  
  final tiburon = new Tiburon();
  tiburon.tipoAgua = "salada";
  print("El tiburon nada en agua: ${tiburon.tipoAgua}");
  tiburon.nadar();
}

/*********Mixins**********/

abstract class Animal {}

abstract class Mamiferos extends Animal {}

abstract class Ave extends Animal {}

abstract class Pez extends Animal {}

// con vana hacer los mixins.

abstract mixin class Nadador{
  String tipoAgua = "dulce";
  void nadar() => print("Estoy nadando...");
}


abstract mixin class Volar{
  void volar() => print("Estoy volando");
}


abstract mixin class Caminar{
  void caminar() => print("Estoy caminando");
}

class Delfin extends Mamiferos with Nadador{}

class Murcielago extends Mamiferos with Volar, Caminar{}

class Gato extends Mamiferos with Caminar{}

class Paloma extends Ave with Volar, Caminar{}

class Tiburon extends Pez with Nadador{}