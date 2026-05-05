void main() async {

  print('Estamos pediendo datos ');

  String data = await httpGet('https://api.nada.com/aliens');

  print(data);
  print('Ultima Linea'); 

}

/*void peticion() async{
  String data = await httpGet('https://api.nada.com/aliens');
}*/

//se llaman como promezas con parando con 
//javascript

// asycn ----me ayuda a transforma una funcion a una tarea
// asyncrona
// await ---- me va a permitir esperar hasta que termine 
// o se resuelve la misma tarea que realice.

Future<String> httpGet (String url){
  return Future.delayed(new Duration( seconds: 3), (){
    return 'hello word';
  });
}