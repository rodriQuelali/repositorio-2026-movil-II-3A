package com.example.myproyectcars.data.remote

import com.example.myproyectcars.data.user.model.User
import com.example.myproyectcars.data.user.model.UserResponse
import retrofit2.http.Body
import retrofit2.http.Headers
import retrofit2.http.POST

interface ApiService {


    @POST("users/")
    @Headers("Content-Type:application/json")
    suspend fun registerUser(@Body user: User): UserResponse
}