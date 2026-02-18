package com.example.myapplicationmvvm.data.remote

import com.example.myapplicationmvvm.data.model.Post
import retrofit2.Call
import retrofit2.http.GET

interface ApiService {

    //lista deempoints.
    @GET("posts")
    fun getPosts(): Call<List<Post>>

}