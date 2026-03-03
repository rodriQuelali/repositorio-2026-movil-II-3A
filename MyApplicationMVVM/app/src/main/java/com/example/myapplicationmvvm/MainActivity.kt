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
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupWithNavController
import com.example.myapplicationmvvm.data.dao.WriteResult
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.ui.viewmodel.PostViewModel
import com.google.android.material.appbar.MaterialToolbar
import com.google.android.material.bottomnavigation.BottomNavigationView

class MainActivity : AppCompatActivity() {

    private val postViewModel: PostViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            // Quitamos el padding superior si usamos la Toolbar como ActionBar
            v.setPadding(systemBars.left, 0, systemBars.right, systemBars.bottom)
            insets
        }

        // 1. Configurar Toolbar
        val toolbar = findViewById<MaterialToolbar>(R.id.toolbar)
        setSupportActionBar(toolbar)

        // 2. Configurar Navegación
        val navHostFragment = supportFragmentManager
            .findFragmentById(R.id.nav_host_fragment) as NavHostFragment
        val navController = navHostFragment.navController

        // 3. Vincular Toolbar con NavController para títulos automáticos
        val appBarConfiguration = AppBarConfiguration(
            setOf(R.id.homeFragment, R.id.listaPostFragment, R.id.registroPostFragment)
        )
        toolbar.setupWithNavController(navController, appBarConfiguration)

        // 4. Vincular BottomNavigation
        val bottomNavigationView = findViewById<BottomNavigationView>(R.id.bottomNavigation)
        bottomNavigationView.setupWithNavController(navController)
    }

    private fun setupObservers() {
        postViewModel.writeResult.observe(this) { result ->
            result?.let {
                when (it) {
                    is WriteResult.Success -> {
                        Toast.makeText(this, it.message, Toast.LENGTH_SHORT).show()
                    }
                    is WriteResult.Error -> {
                        Toast.makeText(this, it.message, Toast.LENGTH_LONG).show()
                    }
                }
            }
        }
    }
}