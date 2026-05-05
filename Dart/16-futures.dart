void main(){

  print("Estamos pidiendo datos");

  httpGet('https://api.nada.com/aliens')
  .then((value) => print(value));

  print('Ultima linea');
  

  

}

/*********Futures**********/
  // llamado de como las promesas.
  //javascript

Future<String> httpGet(String url){
    return Future.delayed(new Duration(seconds: 3),(){
      return 'hello word';
    });
  }



