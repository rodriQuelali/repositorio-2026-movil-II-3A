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

    fun getPosts(){
        repository.getPost(
            callback = { postList -> _posts.value = postList},
            errorCallback = {throwable -> _err.value = throwable.message}
        )
    }

}