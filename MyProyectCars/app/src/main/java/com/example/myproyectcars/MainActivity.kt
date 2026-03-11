package com.example.myproyectcars

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

import com.example.myproyectcars.databinding.ActivityMainNBinding

import com.example.myproyectcars.ui.login.LoginActivity
import com.example.myproyectcars.ui.user.MainActivityUser

class MainActivity : AppCompatActivity() {
    //np se maneja la clase R. Se maneja viewBinding
    //
    private lateinit var binding: ActivityMainNBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main_n)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        binding = ActivityMainNBinding.inflate(layoutInflater)
        setContentView(binding.root)

        var btnlogin = binding.btnLogin
        var btnRegister = binding.btnSignIn

        btnlogin.setOnClickListener {
            var i  = Intent(this, LoginActivity::class.java)
            startActivity(i)
        }

        btnRegister.setOnClickListener {
            var i  = Intent(this, MainActivityUser::class.java)
            startActivity(i)
        }

    }
}