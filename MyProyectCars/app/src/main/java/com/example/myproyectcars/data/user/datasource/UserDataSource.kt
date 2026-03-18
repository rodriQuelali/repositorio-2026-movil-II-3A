package com.example.myproyectcars.data.user.datasource

import android.content.Context
import com.example.myproyectcars.data.remote.ApiClient
import com.example.myproyectcars.data.user.model.User
import com.example.myproyectcars.data.user.model.UserResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import com.example.myproyectcars.data.login.model.Result

class UserDataSource(private val context: Context) {
    /**
     * Registra un nuevo usuario.
     * Retorna Result.Success con los datos del usuario si el status es 201.
     */
    suspend fun registerUser(user: User): Result<UserResponse> {
        return try {
            println("Enviar datos de user email: ${user.email}")

            val response = withContext(Dispatchers.IO){
                ApiClient.create(context).registerUser(user)
            }

            if (response.isSuccessful && response.code() == 201) {
                val userResponse = response.body()
                if (userResponse != null) {
                    println("Registro exitoso (201 Created): $userResponse")
                    Result.Success(userResponse)
                } else {
                    Result.Error(IOException("Error: Cuerpo de respuesta vacío"))
                }
            } else {
                println("Error en registro: Código ${response.code()}")
                Result.Error(IOException("Error en el servidor: ${response.code()}"))
            }
        } catch (e: Exception) {
            // Manejo de errores de conexión o parsing
            println("Error de conexión: ${e.message}")
            Result.Error(IOException("Error en la conexión", e))
        }
    }
}