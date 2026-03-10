package com.example.myapplicationmvvm.ui.post

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.activityViewModels
import com.example.myapplicationmvvm.data.dao.WriteResult
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.databinding.FragmentRegistroPostBinding
import com.example.myapplicationmvvm.ui.viewmodel.PostViewModel

class registroPost : Fragment() {

    // 1. Configuración de View Binding
    private var _binding: FragmentRegistroPostBinding? = null
    private val binding get() = _binding!!

    // 2. Obtener ViewModel compartido con la Activity
    private val postViewModel: PostViewModel by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {

        _binding = FragmentRegistroPostBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setupListeners()
        setupObservers()
    }

    private fun setupListeners() {
        binding.btnGuardar.setOnClickListener {
            val userIdString = binding.etUserId.text.toString()
            val title = binding.etTitle.text.toString()
            val body = binding.etBody.text.toString()

            if (userIdString.isNotEmpty() && title.isNotEmpty() && body.isNotEmpty()) {
                val post = Post(
                    id = 0, // El servidor suele asignar el ID
                    userId = userIdString.toInt(),
                    title = title,
                    body = body
                )
                
                // Llamar al registro
                postViewModel.addPost(post)
            } else {
                Toast.makeText(requireContext(), "Por favor, completa todos los campos", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun setupObservers() {
        postViewModel.writeResult.observe(viewLifecycleOwner) { result ->
            result?.let {
                when (it) {
                    is WriteResult.Success -> {
                        Toast.makeText(requireContext(), it.message, Toast.LENGTH_SHORT).show()
                        clearFields()
                        postViewModel.resetWriteResult() // Limpiar para evitar repeticiones
                    }
                    is WriteResult.Error -> {
                        Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
                        postViewModel.resetWriteResult()
                    }
                }
            }
        }
    }

    private fun clearFields() {
        binding.etUserId.text?.clear()
        binding.etTitle.text?.clear()
        binding.etBody.text?.clear()
        binding.etId.text?.clear()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null // Evitar fugas de memoria
    }
}