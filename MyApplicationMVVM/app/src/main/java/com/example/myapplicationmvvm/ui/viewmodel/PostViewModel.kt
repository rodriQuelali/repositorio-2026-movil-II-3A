package com.example.myapplicationmvvm.ui.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import com.example.myapplicationmvvm.data.dao.PostDao
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.data.repository.PostRepository

class PostViewModel (aplication: Application): AndroidViewModel(aplication){
    //de mi reporsitory que llama a postDao

    private val postDao: PostDao


    //view model mutable Liva date o LivaData
    val posts: LiveData<List<Post>> get() = postDao.posts
    val error: LiveData<String> get() = postDao.err

    //save
    val result: LiveData<Boolean> get() = postDao.result

    //inicalizando automaticamente
    init {
        val postsRepositori = PostRepository()
        postDao = PostDao(postsRepositori)
    }

    fun getPosts(){
        //viewModelScope.launch {
        postDao.getPosts()  // Asumiendo que getPosts() maneja todo internamente
        //}
    }

    fun addPost(post: Post) {
        postDao.addPost(post)
    }

}