
class FormatoLatam {
  
   String resultadoFinalConvertir(double r){
      if(r % 1 == 0){

        return r.toInt().toString();
      }

      return r.toString().replaceAll(".", ",");
    }

    List<String> convertirPunto(String a, String b){
      
      List<String> lista = [];
      if(a.contains(",") || b.contains(",")){
        a = a.replaceAll(",", ".");
        b = b.replaceAll(",", ".");

        lista.add(a);
        lista.add(b);

        return lista;
      }
      return [ a, b ];
    }

}