package com.example.myapplicationtestexamplo

import com.example.myapplicationtestexamplo.data.Impuesto
import com.example.myapplicationtestexamplo.data.Producto
import org.junit.Test
import org.junit.Assert.*

class ImpuestoUnitTest {

    //setupClass
    //setup


    @Test
    fun test_caluculoImpuesto(){
        val imp: Impuesto = Impuesto()
        val ex = imp.calcularImpuesto(Producto("laptop", 150))

        val impuesto = Impuesto.calcularImpuesto(Producto("laptop", 150))
        assertEquals(18.0, ex, 0.1)

    }

    //validen los datos : no anegaticvos
    //ingreso -150, salida: datos incorrectos.
}