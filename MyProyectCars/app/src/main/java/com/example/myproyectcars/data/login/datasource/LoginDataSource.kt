package com.example.myproyectcars.data.login.datasource

import android.content.Context
import com.example.myproyectcars.data.login.model.Result
import com.example.myproyectcars.data.login.model.LoggedInUser
import com.example.myproyectcars.data.remote.ApiClient
import com.example.myproyectcars.data.user.model.LoginRequest
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import java.util.UUID

/**
 * Class that handles authentication w/ login credentials and retrieves user information.
 */
class LoginDataSource(private val context: Context) {

    suspend fun login(username: String, password: String): Result<LoggedInUser> {
        try {
            // TODO: handle loggedInUser authentication
            //llamado a login request...
            val loginResult = LoginRequest(email = username, password = password)


            val loginResponse = withContext(Dispatchers.IO){
                ApiClient.create(context).login(loginResult)
            }
            //llamara login response
            //guardado de localStore, shareprefefences o sqLite
            saveAccessToken(loginResponse.access)
            //val fakeUser = LoggedInUser(java.util.UUID.randomUUID().toString(), "Alna Brito")
            val fakeUser = LoggedInUser(UUID.randomUUID().toString(), loginResult.email)
            return Result.Success(fakeUser)
        } catch (e: Throwable) {
            return Result.Error(IOException("Error logging in", e))
        }
    }

    fun logout() {
        // TODO: revoke authentication
    }

    //funcion de mi guardado del token.
    private fun saveAccessToken(token:String){
        val sharedPreferences = context.getSharedPreferences("AppPreferences", Context.MODE_PRIVATE)
        with(sharedPreferences.edit()){
            remove("ACCESS_TOKEN")
            apply()
        }
    }

    //funcion para eliminar el token.
}