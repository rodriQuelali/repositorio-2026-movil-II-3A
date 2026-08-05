
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
  
  String _a;
  String _b;
  FormatoLatam formato = FormatoLatam();

  Calculadora(this._a , this._b);

  
    //metodo suma, recibe dos string, los convierte a double, realiza la operacion y devuelve el resultado en formato latinoamericano
    //[a]: [String], numero 1
    //[b]: [String], numero 2
    String suma(){
      
      List<String>numeros = formato.convertirPunto(_a, _b);
      this._a = numeros[0]; //12.9
      this._b = numeros[1]; //2.1
      var r = ((double.parse(_a) + double.parse(_b)));
     
      return formato.resultadoFinalConvertir(r);
    }

    String resta(){
      
      List<String>numeros = formato.convertirPunto(_a, _b);
      this._a = numeros[0]; //12.9
      this._b = numeros[1]; //2.1
      var r = ((double.parse(_a) - double.parse(_b)));
     
      return formato.resultadoFinalConvertir(r);
    }

    //resto de las opraciones
    //analizar la division, utilizar S.

    //mejorar la UI. p
}