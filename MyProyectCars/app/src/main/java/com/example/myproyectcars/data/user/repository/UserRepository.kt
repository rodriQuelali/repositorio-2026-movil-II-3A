package com.example.myproyectcars.data.user.repository

import com.example.myproyectcars.data.user.datasource.UserDataSource
import com.example.myproyectcars.data.user.model.User
import com.example.myproyectcars.data.user.model.UserResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import com.example.myproyectcars.data.login.model.Result


class UserRepository (private val dataSource: UserDataSource){
    // Cache opcional del último usuario registrado (siguiendo tu lógica de Login)
    var registeredUser: UserResponse? = null
        private set

    /**
     * Registra un nuevo usuario delegando al DataSource.
     */
    suspend fun register(user: User): Result<UserResponse> {
        return withContext(Dispatchers.IO) {
            val result = dataSource.registerUser(user)

            if (result is Result.Success) {
                // Si el registro fue exitoso, guardamos en caché local (opcional)
                setRegisteredUser(result.data)
            }
            result
        }
    }

    private fun setRegisteredUser(user: UserResponse) {
        this.registeredUser = user
    }
}