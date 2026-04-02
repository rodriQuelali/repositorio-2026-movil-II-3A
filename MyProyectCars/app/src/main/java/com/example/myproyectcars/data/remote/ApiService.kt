package com.example.myproyectcars.data.remote

import com.example.myproyectcars.data.user.model.LoginRequest
import com.example.myproyectcars.data.user.model.LoginResponse
import com.example.myproyectcars.data.user.model.User
import com.example.myproyectcars.data.user.model.UserResponse
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.Headers
import retrofit2.http.POST

interface ApiService {

    //empoints de login
    @POST("auth/api/token/")
    @Headers("Content-Type:application/json")
    suspend fun login(@Body loginRequest: LoginRequest): LoginResponse

    @POST("users/")
    @Headers("Content-Type:application/json")
    suspend fun registerUser(@Body user: User): Response<UserResponse>

}