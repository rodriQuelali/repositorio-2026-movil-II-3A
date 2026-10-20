package com.example.myapplicationtestexamplo.data

class Nota {
    fun calcularNota(estudiante: Estudiante): Boolean{
        return estudiante.nota >= 61
    }

    fun validarNotas(estudiante: Estudiante): String{
        if(estudiante.nota in 1..100){
            return "Bien"
        }
        return "nota invalida"
    }








    fun validarNota(estudiante: Estudiante): Boolean{
        if(estudiante.nota < 0 || estudiante.nota > 100){
            throw IllegalArgumentException("nota invalida")
        }
        /*require(estudiante.nota < 0 || estudiante.nota > 100){
            println("............................>>>>")
            "nota invalida"
        }*/
        return true
    }
}