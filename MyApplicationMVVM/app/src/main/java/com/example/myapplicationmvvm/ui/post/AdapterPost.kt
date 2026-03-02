package com.example.myapplicationmvvm.ui.post

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.databinding.ItemPostBinding

class AdapterPost(
    private val onEditClick: (Post) -> Unit,
    private val onDeleteClick: (Post) -> Unit
) : ListAdapter<Post, AdapterPost.PostViewHolder>(DIFF_CALLBACK) {

    // 1️⃣ DiffUtil compara listas vieja vs nueva automáticamente
    companion object {
        private val DIFF_CALLBACK = object : DiffUtil.ItemCallback<Post>() {

            // Compara si son el mismo item (ej: mismo id)
            override fun areItemsTheSame(oldItem: Post, newItem: Post): Boolean {
                return oldItem.id == newItem.id
            }

            // Compara si el contenido cambió
            override fun areContentsTheSame(oldItem: Post, newItem: Post): Boolean {
                return oldItem == newItem
            }
        }
    }

    // 2️⃣ ViewHolder usando ViewBinding
    inner class PostViewHolder(val binding: ItemPostBinding) :
        RecyclerView.ViewHolder(binding.root)

    // 3️⃣ Inflamos el XML del item con ViewBinding
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PostViewHolder {

        val binding = ItemPostBinding.inflate(
            LayoutInflater.from(parent.context),
            parent,
            false
        )

        return PostViewHolder(binding)
    }

    // 4️⃣ Aquí conectamos datos con las vistas
    override fun onBindViewHolder(holder: PostViewHolder, position: Int) {

        val post = getItem(position)
        holder.binding.tvUserId.text = post.userId.toString()
        holder.binding.tvTitle.text = post.title
        holder.binding.tvBody.text = post.body

        // 🔥 BOTÓN EDITAR
        holder.binding.btnEditar.setOnClickListener {
            onEditClick(post)
        }

        // 🔥 BOTÓN ELIMINAR
        holder.binding.btnEliminar.setOnClickListener {
            onDeleteClick(post)
        }
    }
}