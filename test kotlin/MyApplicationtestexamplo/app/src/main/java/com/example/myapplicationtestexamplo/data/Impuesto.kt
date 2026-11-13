package com.example.myapplicationtestexamplo.data

class Impuesto {

    //instancia
    fun calcularImpuesto(producto: Producto): Double = producto.precio * 0.12


    //funcvion static o estartica
    companion object {
        fun calcularImpuesto(producto: Producto): Double = producto.precio * 0.12
    }


}