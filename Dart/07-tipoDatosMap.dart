void main(){

  // tipo de datos Map, 
  // es una coleccion de pares clave-valor, donde cada clave es unica y se asocia a un valor.
  // php -- array asociativo
  // python -- diccionario

  var personaDinamica = {
    "nombre": "rodrigo",
    "edad": 30,
    "esEstudiante": 1.65
  };

  //tipado estricto
  Map <String, Object> persona = {
    "nombre": "rodrigo",
    "edad": 30,
    "esEstudiante": 1.65
  };
  print(persona["nombre"]);

  Map <int, dynamic> numeros = {
    1: "uno", // cuatro
    2: "dos",
    3: "tres"
  };

  // agregar un nuevo par clave-valor
  numeros[4] = "cuatro";
  print(numeros);





}