package com.example.myapplicationmvvm.data.remote

import com.example.myapplicationmvvm.data.model.Post
import retrofit2.Call
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.POST

interface ApiService {

    //lista deempoints.
    @GET("posts")
    fun getPosts(): Call<List<Post>>

    @POST("posts")
    fun savePost(): Any

    //@DELETE("posts")
    //fun delete(val id):

}