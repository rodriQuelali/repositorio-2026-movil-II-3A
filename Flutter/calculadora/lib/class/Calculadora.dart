
import 'package:calculadora/class/FormatoLatam.dart';

/// descripcion o una introduccion de la clase
/// Calse calcualdora, operacion basicas en fromato latinoamericano, ejemplo: 12,9 + 2,1 = 15,0
/// @property a [String]
/// @property b [String]
/// @return resulato de la operacion
/// @author: 3ro A
/// @version: 1.0
/// 
class Calculadora{
  
  FormatoLatam formato = FormatoLatam();

  Calculadora(String a, String b);

  
    //metodo suma, recibe dos string, los convierte a double, realiza la operacion y devuelve el resultado en formato latinoamericano
    //[a]: [String], numero 1
    //[b]: [String], numero 2
    String suma(){
      
      List<String>numeros = formato.convertirPunto(a, b);
      this.a = numeros[0]; //12.9
      this.b = numeros[1]; //2.1
      var r = ((double.parse(a) + double.parse(b)));
     
      return formato.resultadoFinalConvertir(r);
    }

   

}