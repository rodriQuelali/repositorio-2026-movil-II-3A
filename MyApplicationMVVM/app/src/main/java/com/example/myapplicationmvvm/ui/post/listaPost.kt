package com.example.myapplicationmvvm.ui.post

import android.app.AlertDialog
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.myapplicationmvvm.data.dao.WriteResult
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.databinding.DialogDeletePostBinding
import com.example.myapplicationmvvm.databinding.DialogEditPostBinding
import com.example.myapplicationmvvm.databinding.FragmentListaPostBinding
import com.example.myapplicationmvvm.ui.viewmodel.PostViewModel

class listaPost : Fragment() {
    private var param1: String? = null
    private var param2: String? = null

    private var _binding: FragmentListaPostBinding? = null
    private val binding get() = _binding!!

    private lateinit var adapterPost: AdapterPost
    private val postViewModel: PostViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString("param1")
            param2 = it.getString("param2")
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentListaPostBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        adapterPost = AdapterPost(
            onEditClick = { post ->
                showEditDialog(post)
            },
            onDeleteClick = { post ->
                showDeleteDialog(post)
            }
        )

        binding.recyclerPosts.apply {
            layoutManager = LinearLayoutManager(requireContext())
            adapter = adapterPost
        }

        observerListPost()
        executeListPost()
    }

    fun observerListPost() {
        // Observador de la lista de posts
        postViewModel.posts.observe(viewLifecycleOwner) { posts ->
            posts?.let {
                adapterPost.submitList(it)
            }
        }

        // Observador de errores generales (ej: carga de lista)
        postViewModel.error.observe(viewLifecycleOwner) { errorMessage ->
            errorMessage?.let {
                Log.e("Error_Lista", it)
                Toast.makeText(requireContext(), it, Toast.LENGTH_SHORT).show()
            }
        }

        // 🟢 NUEVO: Observador para el resultado de Editar y Eliminar
        postViewModel.writeResult.observe(viewLifecycleOwner) { result ->
            result?.let {
                when (it) {
                    is WriteResult.Success -> {
                        Toast.makeText(requireContext(), it.message, Toast.LENGTH_SHORT).show()
                        // Refrescamos la lista automáticamente tras el éxito
                        executeListPost()
                        // Limpiamos el resultado para no repetir el mensaje
                        postViewModel.resetWriteResult()
                    }
                    is WriteResult.Error -> {
                        Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                        postViewModel.resetWriteResult()
                    }
                }
            }
        }
    }

    fun executeListPost() = postViewModel.getPosts()

    private fun showEditDialog(post: Post) {
        val dialogBinding = DialogEditPostBinding.inflate(layoutInflater)
        val dialog = AlertDialog.Builder(requireContext())
            .setView(dialogBinding.root)
            .create()

        dialog.show()

        dialogBinding.etUserId.setText(post.userId.toString())
        dialogBinding.etId.setText(post.id.toString())
        dialogBinding.etTitle.setText(post.title)
        dialogBinding.etBody.setText(post.body)

        dialogBinding.btnSave.setOnClickListener {
            val updatedPost = Post(
                userId = dialogBinding.etUserId.text.toString().toIntOrNull() ?: 0,
                id = dialogBinding.etId.text.toString().toIntOrNull() ?: 0,
                title = dialogBinding.etTitle.text.toString(),
                body = dialogBinding.etBody.text.toString()
            )

            postViewModel.updatePost(updatedPost.id, updatedPost)
            dialog.dismiss()
        }
    }

    private fun showDeleteDialog(post: Post) {
        val dialogBinding = DialogDeletePostBinding.inflate(layoutInflater)
        val dialog = AlertDialog.Builder(requireContext())
            .setView(dialogBinding.root)
            .create()

        dialog.show()

        dialogBinding.btnConfirmDelete.setOnClickListener {
            postViewModel.deletePost(post.id)
            dialog.dismiss()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    companion object {
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            listaPost().apply {
                arguments = Bundle().apply {
                    putString("param1", param1)
                    putString("param2", param2)
                }
            }
    }
}