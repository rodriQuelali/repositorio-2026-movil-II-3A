class Calculadora{

    String suma(String a, String b){
      List<String>numeros = convertirPunto(a, b);
      a = numeros[0]; //12.9
      b = numeros[1]; //2.1
      var r = ((double.parse(a) + double.parse(b)).toString()).replaceAll(".", ",");
      //tarea correccion de bug.
      //r = .0
      return r;
    }

    List<String> convertirPunto(String a, String b){
      //solucionar el bug, tarea...
      //lista para alamcenar a y b
      List<String> lista = [];
      if(a.contains(",") || b.contains(",")){
        a = a.replaceAll(",", ".");
        b = b.replaceAll(",", ".");

        //var r = ((double.parse(a) + double.parse(b)).toString()).replaceAll(".", ",");
        lista.add(a);
        lista.add(b);
        return lista;
      }
      return [ a, b ];
    }

}