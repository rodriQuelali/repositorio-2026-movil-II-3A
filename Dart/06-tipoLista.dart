void main(){
  // tipo de lista o vector.

  //tipado dinamico
  var lista = [1,2,3,4,5];
  //tipado stricto 
  List <String>nombres = ["rodrigo", "juan"];
  //print(nombres);
  nombres.add("flor");
  //print(nombres);
  List <Object> cosas = [1, "hola", true];

  //lista de tamaño fijo
  var maasNumeros = new List.filled(10, null);
  //o
  List masNumeros = List.filled(10, null);
  
  print(maasNumeros);



}