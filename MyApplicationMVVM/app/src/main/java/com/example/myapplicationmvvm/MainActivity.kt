package com.example.myapplicationmvvm

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController
import com.example.myapplicationmvvm.data.dao.WriteResult
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.ui.viewmodel.PostViewModel
import com.google.android.material.bottomnavigation.BottomNavigationView

class MainActivity : AppCompatActivity() {

    private val postViewModel: PostViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Observadores
        //setupObservers()
        //observerListPost()

        val navHostFragment = supportFragmentManager
            .findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        val navController = navHostFragment.navController

        val bottomNavigationView = findViewById<BottomNavigationView>(R.id.bottomNavigation)
        bottomNavigationView.setupWithNavController(navController)

        //executeListPost()
        //executeDeletePost(1)
        //executeUpdatePost(1, Post(1, 1, "titulo", "contenido"))
    }

    private fun setupObservers() {
        // Observamos el resultado de creación/edición con mensajes personalizados
        postViewModel.writeResult.observe(this) { result ->
            result?.let {
                when (it) {
                    is WriteResult.Success -> {
                        Toast.makeText(this, it.message, Toast.LENGTH_SHORT).show()
                        Log.d("API_SUCCESS", it.message)
                    }
                    is WriteResult.Error -> {
                        Toast.makeText(this, it.message, Toast.LENGTH_LONG).show()
                        Log.e("API_ERROR", it.message)
                    }
                }
            }
        }
    }

    fun observerListPost(){
        postViewModel.posts.observe(this){ posts ->
            posts?.forEach {
                Log.d("POSTS","-------------Data response: ${it.body}")
            }
        }

        postViewModel.error.observe(this){ errorMessage ->
            errorMessage?.let {
                Log.e("Error_API", it)
            }
        }
    }

    fun executeListPost() = postViewModel.getPosts()
    
    fun savePost(post: Post) = postViewModel.addPost(post)

    fun executeDeletePost(id: Int) = postViewModel.deletePost(id)

    fun executeUpdatePost(id: Int, post: Post) = postViewModel.updatePost(id, post)
}