void main(){
  //Tipo de datos

  // String, int, double, bool
  String nombre = "Rodrigo";
  int edad = 30;
  double altura = 1.85;
  bool estado = true;


  print("Hola $nombre, tu edad es $edad, tu altura es $altura y tu estado es $estado");

  // var --> se maneja el tipo de datos automatico
  var pi = 3.14;
  //pi = "3.1416"; --- esta me da error
  print("El valor de pi es $pi");

  //dynamic --> se puede cambiar el tipo de datos

  dynamic varibleCambio = "Hola";
  print(varibleCambio);
  varibleCambio = 123;
  print(varibleCambio);


}