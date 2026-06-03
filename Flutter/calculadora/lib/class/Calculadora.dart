class Calculadora{

    String convertirPunto(String a, String b){
      //solucionar el bug, tarea...
      if(a.contains(",") && b.contains(",")){
        a.replaceAll(",", ".");
        b.replaceAll(",", ".");
        return (double.parse(a) + double.parse(b)).toString();
      }
      return "0.0";
    }

}