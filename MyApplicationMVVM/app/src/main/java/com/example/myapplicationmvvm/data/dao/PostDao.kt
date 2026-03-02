package com.example.myapplicationmvvm.data.dao

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.data.repository.PostRepository

// Clase para manejar el resultado de las operaciones de escritura
sealed class WriteResult {
    data class Success(val message: String) : WriteResult()
    data class Error(val message: String) : WriteResult()
}

class PostDao(private val repository: PostRepository) {
    private val _posts = MutableLiveData<List<Post>>()
    val posts : LiveData<List<Post>> get() = _posts

    private val _err = MutableLiveData<String>()
    val err : LiveData<String> get() = _err

    // Ahora el resultado es de tipo WriteResult
    private val _writeResult = MutableLiveData<WriteResult?>()
    val writeResult: LiveData<WriteResult?> get() = _writeResult

    fun getPosts(){
        repository.getPost(
            callback = { postList -> _posts.value = postList ?: emptyList()},
            errorCallback = {throwable -> _err.value = throwable.message}
        )
    }

    fun addPost(post: Post) {
        repository.createRespositoryPost(post, callback = {
            _writeResult.value = WriteResult.Success("Post creado correctamente")
        }, errorCallback = { throwable ->
            _writeResult.value = WriteResult.Error("Error al crear el post: ${throwable.message}")
        })
    }

    fun updatePost(id: Int, post: Post) {
        repository.updateRepositoryPost(id, post, callback = {
            _writeResult.value = WriteResult.Success("Post actualizado correctamente")
        }, errorCallback = { throwable ->
            _writeResult.value = WriteResult.Error("Error al actualizar el post: ${throwable.message}")
        })
    }

    // Método opcional para limpiar el estado después de mostrar el mensaje
    fun resetWriteResult() {
        _writeResult.value = null
    }
}