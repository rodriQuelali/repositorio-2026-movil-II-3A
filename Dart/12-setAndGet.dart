void main(){
  Cuadrado cuadrado1 = Cuadrado();
  cuadrado1.lado = 5;
  print(cuadrado1.toString());


}

/*set y get, son metodos especiales que se 
utilizan para acceder a las propiedades de 
una clase, el set se utiliza para asignar un 
valor a una propiedad, y el get se utiliza 
para obtener el valor de una propiedad.*/

class Cuadrado{

  // late, nose asigna un valor de la varible, pero se asegura 
  // que se asigna el valorantes de utilizarlo.
  // _ privado.
  late double _lado;

  //set
  set lado(double valor){
    //validacion del valor no ay negativo
    _lado = valor;
  }
  //get 
  get lado{
    return _lado;
  }

  @override
  String toString() {
    return 'Cuadrado: Lado: $_lado';
  }
  
}