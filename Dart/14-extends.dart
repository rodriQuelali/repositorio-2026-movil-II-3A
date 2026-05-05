void main(){

  final estudiante1 = new Estudiante();
  estudiante1.nombre = "alan";

  final docente1 = new Docente();
  docente1.nombre = "rodrigo";

  print("estudiante: ${estudiante1.nombre}");
  print("docente: ${docente1.nombre}");

  estudiante1.caminar();

}
//si se puede hacer la herencia pero no se puede hacer la instancia de ella
abstract class Persona{
  String? nombre;
  int? edad;
  void caminar();
  //void hablar();

}

class Estudiante extends Persona{
  String? carrera;

  @override
  void caminar() {
    print("El estudiante esta caminando");
  }
}

class Docente extends Persona{
  String? materia;

  @override
  void caminar() {
    print("El docente esta caminando");
  }
}




//si se puede hacer la instancias pero no se puede heredar de ella
/*final class Personas{
  String? nombre;
  int? edad;
}*/