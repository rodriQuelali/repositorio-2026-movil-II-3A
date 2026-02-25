package com.example.myapplicationmvvm.data.repository

import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.data.remote.ApiClient
import com.example.myapplicationmvvm.data.remote.ApiService
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class PostRepository {
    //insyancia al apiService
    val apiService: ApiService = ApiClient.instancia

    fun getPost(callback: (List<Post>?)->Unit, errorCallback: (Throwable)-> Unit){
        apiService.getPosts().enqueue(object : Callback<List<Post>> {
            override fun onResponse(call: Call<List<Post>>, response: Response<List<Post>>){
                if (response.isSuccessful){
                    callback(response.body())
                }else{
                    errorCallback(Exception("Error ${response.code()}"))
                }
            }

            override fun onFailure(call: Call<List<Post>>, t: Throwable) {
                errorCallback(t)
            }
        })
    }
    //save
    fun createRespositoryPost(post: Post, callback: (Post) -> Unit, errorCallback: (Throwable) -> Unit) {
        apiService.createPost(post).enqueue(object : Callback<Post> {
            override fun onResponse(call: Call<Post>, response: Response<Post>) {
                if (response.isSuccessful) {
                    callback(response.body()!!)
                    //callback() cuando solo devuelve un 200, ok sin cuerpo.
                } else {
                    errorCallback(Throwable("Error en la respuesta"))
                }
            }

            override fun onFailure(call: Call<Post>, t: Throwable) {
                errorCallback(t)
            }
        })
    }

}