package com.example.myapplicationmvvm.data.dao

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.data.repository.PostRepository

class PostDao(private val repository: PostRepository) {
    private val _posts = MutableLiveData<List<Post>>()
    val posts : LiveData<List<Post>> get() = _posts

    private val _err = MutableLiveData<String>()
    val err : LiveData<String> get() = _err

    //estado save
    private val _result = MutableLiveData<Boolean>()
    val result: LiveData<Boolean> get() = _result

    fun getPosts(){
        repository.getPost(
            callback = { postList -> _posts.value = postList},
            errorCallback = {throwable -> _err.value = throwable.message}
        )
    }



    fun addPost(post: Post) {
        repository.createRespositoryPost(post, callback = {
            _result.value = true // Éxito en el guardado
        }, errorCallback = { throwable ->
            _result.value = false // Error en el guardado
        })
    }

}