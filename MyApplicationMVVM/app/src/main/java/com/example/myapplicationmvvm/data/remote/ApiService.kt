package com.example.myapplicationmvvm.data.remote

import com.example.myapplicationmvvm.data.model.Post
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.PATCH
import retrofit2.http.POST
import retrofit2.http.PUT
import retrofit2.http.Path

interface ApiService {

    //lista deempoints.
    @GET("posts")
    fun getPosts(): Call<List<Post>>

    @POST("posts")
    fun createPost(@Body post: Post): Call<Post>

    //@DELETE("posts")
    //fun delete(val id):
    // Actualizar un post completo
    @PUT("posts/{id}")
    fun updatePost(@Path("id") id: Int, @Body post: Post): Call<Post>

    // Actualizar un post parcialmente
    @PATCH("posts/{id}")
    fun patchPost(@Path("id") id: Int, @Body post: Post): Call<Post>

    // Eliminar un post
    @DELETE("posts/{id}")
    fun deletePost(@Path("id") id: Int): Call<Unit>

}