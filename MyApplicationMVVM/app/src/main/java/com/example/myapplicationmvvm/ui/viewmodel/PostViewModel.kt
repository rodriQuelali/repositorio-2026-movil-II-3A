package com.example.myapplicationmvvm.ui.viewmodel

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import com.example.myapplicationmvvm.data.dao.PostDao
import com.example.myapplicationmvvm.data.dao.WriteResult
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.data.repository.PostRepository

class PostViewModel(application: Application) : AndroidViewModel(application) {
    private val postDao: PostDao

    val posts: LiveData<List<Post>> get() = postDao.posts
    val error: LiveData<String> get() = postDao.err

    // Agregamos la referencia al resultado de escritura
    val writeResult: LiveData<WriteResult?> get() = postDao.writeResult

    init {
        val postsRepository = PostRepository()
        postDao = PostDao(postsRepository)
    }

    fun getPosts() {
        postDao.getPosts()
    }

    fun addPost(post: Post) {
        postDao.addPost(post)
    }

    fun updatePost(id: Int, post: Post) {
        postDao.updatePost(id, post)
    }

    fun resetWriteResult() {
        postDao.resetWriteResult()
    }
}