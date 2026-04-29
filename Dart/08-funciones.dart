
void main(){

  //saludarPersona("Daniela");
  //print(sumarNumeros(2,90));
  print(mensajess(texto: "hola", nombre: "rodrigo"));

}

//procedmiento
void saludar(){
  print("hola");
}
//funcion
int sumar(){
  return 2 + 3;
}

//funciones con parametros
void saludarPersona(String nombre){
  print("hola $nombre");
}

int sumarNumeros(int a, int b) => a + b;


//funcion con prioridad, no permite valores null, se coloca  ? 
//para indicar que va apermitir null, y si no coloca o asigna un valor preterminado
//
String mensajess ({String? texto, String? nombre}){
  return '$texto $nombre';
}