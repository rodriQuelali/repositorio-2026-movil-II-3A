package com.example.myapplicationtestexamplo

import com.example.myapplicationtestexamplo.data.Calculadora
import org.junit.Test
import org.junit.Assert.*
import org.junit.Before
import org.junit.BeforeClass

//crear una clase Calculadora.
    /** Crear una funcio suma()
    realizar las siguientes pruebas:
    - 2 + 2 = 4
    - 2.1 + 2.1 = 4.2
    - "2" + "2" = 4, "Ingrese numeros"
    * */

class CalculadoraUnitTest {

    //desde setup --- creando desde la clase.
    private lateinit var calculadora: Calculadora

    /*
    * setup ---> @Before, se ejecuta de cada funcion.
    * setupClass ---> @BeforeClass, se ejecuta una sola vez.*/
    companion object{
        //dentro de setupclass
        lateinit var calculadora2: Calculadora

        @JvmStatic
        @BeforeClass
        fun setupClass(){
            println("setupClass .................")
            calculadora2 = Calculadora()
        }
    }

    @Before
    fun setup(){
        println("setup .................")
        calculadora = Calculadora()

    }

    @Test
    fun suma_test(){

        val res = calculadora2.suma(2.1,2.1)
        println("----------------------$res")
        assertEquals(4.2, res, 0.1)
    }

        @Test
        fun resta_test(){
            //val calculadora = Calculadora()
            val res = calculadora.resta(2,2)
            println("----------------------$res")
            assertEquals(0, res)
        }
}