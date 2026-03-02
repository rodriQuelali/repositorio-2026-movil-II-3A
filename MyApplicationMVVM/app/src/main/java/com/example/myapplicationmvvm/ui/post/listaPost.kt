package com.example.myapplicationmvvm.ui.post

import android.app.AlertDialog
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.viewModels
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.myapplicationmvvm.R
import com.example.myapplicationmvvm.data.model.Post
import com.example.myapplicationmvvm.databinding.DialogDeletePostBinding
import com.example.myapplicationmvvm.databinding.DialogEditPostBinding
import com.example.myapplicationmvvm.databinding.FragmentListaPostBinding
import com.example.myapplicationmvvm.ui.viewmodel.PostViewModel
import kotlin.getValue

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [listaPost.newInstance] factory method to
 * create an instance of this fragment.
 */
class listaPost : Fragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    private var _binding: FragmentListaPostBinding? = null
    private val binding get() = _binding!!

    private lateinit var adapterPost: AdapterPost
    private val postViewModel: PostViewModel by viewModels ()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inflate the layout for this fragment
        _binding = FragmentListaPostBinding.inflate(inflater, container, false)
        return  binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // 4️⃣ Inicializamos adapter
        adapterPost = AdapterPost(
            onEditClick = { post ->
                showEditDialog(post)
            },

            onDeleteClick = { post ->
                showDeleteDialog(post)
            }
        )
        binding.recyclerPosts.adapter = adapterPost

        // 5️⃣ Conectamos RecyclerView
        binding.recyclerPosts.apply {
            layoutManager = LinearLayoutManager(requireContext())
            adapter = adapterPost
        }

        val listaPrueba = listOf(
            Post(
                userId = 1, title = "Titulo 1", body = "Contenido 1"
            ),
            Post(
                userId = 2, title = "Titulo 1", body = "Contenido 1"
            ),

        )

        observerListPost()
        executeListPost()
        // 🔥 Aquí está la magia de ListAdapter
        //adapterPost.submitList(listaPrueba)


    }

    //funcion para el observer
    fun observerListPost(){
        postViewModel.posts.observe(viewLifecycleOwner){ posts ->
            posts?.let {
                adapterPost.submitList(it)

                it.forEach { post ->
                    Log.d("POSTS", "Body: ${post.body}")
                }
                //Log.d("POSTS","-------------Data response: ${it.body}")
                //println("tipo de datos -------${it::class.simpleName}")
            }

        }

        postViewModel.error.observe(viewLifecycleOwner){ errorMessage ->
            errorMessage?.let {
                Log.e("Error................", it)
            }

        }

    }
    //funcion para llamado ala fucnion getPosts del viewModel
    fun executeListPost() = postViewModel.getPosts()


    private fun showEditDialog(post: Post) {

        val dialogBinding = DialogEditPostBinding.inflate(layoutInflater)

        val dialog = AlertDialog.Builder(requireContext())
            .setView(dialogBinding.root)
            .create()

        dialog.show()

        // 🔥 Cargar datos actuales
        dialogBinding.etUserId.setText(post.userId.toString())
        dialogBinding.etId.setText(post.id.toString())
        dialogBinding.etTitle.setText(post.title)
        dialogBinding.etBody.setText(post.body)

        // 🔥 Guardar cambios
        dialogBinding.btnSave.setOnClickListener {

            val updatedPost = Post(
                userId = dialogBinding.etUserId.text.toString().toIntOrNull() ?: 0,
                id = dialogBinding.etId.text.toString().toIntOrNull() ?: 0,
                title = dialogBinding.etTitle.text.toString(),
                body = dialogBinding.etBody.text.toString()
            )

            //postViewModel.editarPost(updatedPost)

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

            //postViewModel.eliminarPost(post.id)

            dialog.dismiss()
        }
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment listaPost.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            listaPost().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}