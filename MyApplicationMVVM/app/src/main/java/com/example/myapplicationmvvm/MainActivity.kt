package com.example.myapplicationmvvm

import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.ViewModel
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.ui.viewmodel.PostViewModel

class MainActivity : AppCompatActivity() {

    private val postViewModel: PostViewModel by viewModels()
    private lateinit var newPost : Post

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //setupObservers()

        //newPost = Post(1, 2,"Nuevo Post", "Contenido del post")
        //savePost()



        observerListPost()

        executeListPost()

    }

    //funcion para el observer
    fun observerListPost(){
        postViewModel.posts.observe(this){ posts ->
            posts?.forEach {
                Log.d("POSTS","-------------Data response: ${it.body}")
                println("tipo de datos -------${it::class.simpleName}")
            }

        }

        postViewModel.error.observe(this){ errorMessage ->
            errorMessage?.let {
                Log.e("Error................", it)
            }

        }

    }
    //funcion para llamado ala fucnion getPosts del viewModel
    fun executeListPost() = postViewModel.getPosts()
    //practicas
    //realizar el crud con UI (POST), Fragment puntos extras, con busqueda por Title filtrado,(POO) Obtencion de errores,
    //
    // request y response manejando los estados del HTTP.


    //observer save post
    private fun setupObservers() {
        postViewModel.result.observe(this) { isSuccess ->
            if (isSuccess) {
                Log.d("Post", "Post guardado exitosamente")
                // Actualiza la UI para reflejar el éxito
            } else {
                Log.e("Post", "Error al guardar el post")
                // Muestra un mensaje de error en la UI
            }
        }
    }
    //funcion de save
    fun savePost() = postViewModel.addPost(newPost)
}