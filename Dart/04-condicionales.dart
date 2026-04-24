void main(){
  //condicionales
  //if 
  bool esMayorDeEdad = true;
 
  if(esMayorDeEdad){
    print("si es mayor");
  }

  int a = 20;
  int b= 0;
  if(b!=0){
    print("La division es: ${a/b}");
  }else{
    print("No se puede dividir por cero");
  }

  //if ternarios
  String resultado = (b!=0) ? "la divisio 2 es${a/b}" : "no se puede realizar la division2";
  print(resultado);
  print((b!=0) ? "la divisio 3 es${a/b}" : "no se puede realizar la division3");


// if anidados
  if(b>0){
    print("La division es: ${a/b}");
  }else if(a!=0){
    print("No se puede dividir por cero");
  }else if(a==0){
    print("El resultado es cero");  
  }else{
    print("condicion no valida"); 
  }
  //case , switch

  switch(a){
    case 0:
      print("El resultado es cero");
      break;
    case 1:
      print("El resultado es uno");
      break;
    default:
      print("El resultado es diferente a cero y uno");
  }
}