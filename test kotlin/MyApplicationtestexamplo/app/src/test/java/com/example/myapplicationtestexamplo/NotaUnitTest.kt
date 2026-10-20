package com.example.myapplicationtestexamplo

import com.example.myapplicationtestexamplo.data.Estudiante
import com.example.myapplicationtestexamplo.data.Nota
import org.junit.Before
import org.junit.Assert.*
import org.junit.Test

class NotaUnitTest {
    /**
     * Clase Estudiante: Nombre, nota.
     * Clase Nota: calcularNota(Estudiante) return aprobo(true) o reprobo(false)
     *
     * validacion de datos: 1 al 100
     *
     * input : alan brito , -20.
     *
     * output : pasa el test con le mensaje "nota invalida"
     *
     * */
    private lateinit var nota: Nota

    @Before
    fun setup() {
        nota = Nota()
    }

    @Test
    fun notaAprobada_test(){
        val res = nota.calcularNota(Estudiante("alan brito", 85))
        assertTrue(res)
    }

    @Test
    fun notaReprobado_test(){
        val res = nota.calcularNota(Estudiante("alan brito", 45))
        assertFalse(res)
    }

    @Test
    fun notaValida_test(){
        val res = nota.validarNotas(Estudiante("alan brito", -45))
        assertEquals("nota invalida", res)
    }



    //menejo de expciones
    @Test(expected = IllegalArgumentException::class)
    fun notaInvalida_test(){
        val res = nota.validarNota(Estudiante("alan brito", 20))
        println("+++++++++++${res}")
        assertTrue(res)
    }
}