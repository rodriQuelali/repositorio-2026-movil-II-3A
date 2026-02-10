package com.example.myapplicationvolley

import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import org.json.JSONArray

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        cargarHttpPosts()
    }

    //request
    fun cargarHttpPosts(){

        val queue = Volley.newRequestQueue(this)
        val url = "https://jsonplaceholder.typicode.com/posts"

        val stringRequest = StringRequest(
            Request.Method.GET,
            url,
            { response ->
                //val parsearPostsClass: vienModelJsonplaceHOlder
                val listaPosts = parsearPosts(response)
                println("DAtaaaaaaaaa")
                println(listaPosts)
                println("DAtaaaaaaaaa FInnnnn")
                //adapter.submitList(listaPosts) // RecyclerView
            },
            { error ->
                Log.e("VOLLEY", "Error en la petición", error)
            }
        )

        queue.add(stringRequest)
    }

    //response
    fun parsearPosts(response: String): List<JsonplaceHolder> {
        val lista = mutableListOf<JsonplaceHolder>()
        val jsonArray = JSONArray(response)

        for (i in 0 until jsonArray.length()) {
            val obj = jsonArray.getJSONObject(i)

            val post = JsonplaceHolder(
                userId = obj.getInt("userId"),
                id = obj.getInt("id"),
                title = obj.getString("title"),
                body = obj.getString("body")
            )

            lista.add(post)
        }

        return lista
    }
}