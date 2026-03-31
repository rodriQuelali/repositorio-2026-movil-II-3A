package com.example.myproyectcars.ui.user

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.myproyectcars.R
import com.example.myproyectcars.data.user.model.User
import com.example.myproyectcars.databinding.ActivityMainUserBinding
import com.example.myproyectcars.ui.login.LoginActivity

class MainActivityUser : AppCompatActivity() {

    private lateinit var userViewModel: UserViewModel
    private lateinit var binding: ActivityMainUserBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main_user)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        //todo reaalizado en onCreate

        binding = ActivityMainUserBinding.inflate(layoutInflater)
        setContentView(binding.root)

        //inicializar lo que es factory
        userViewModel= ViewModelProvider(this, UserViewModelFactory(this))
            .get(UserViewModel::class.java)

        //UI con binding
        val firtName = binding.firstName
        val lastName = binding.lastName
        val email = binding.registerEmail
        val password = binding.registerPassword
        val registroButton = binding.register

        //llamado a los observer
        //userFormState
        userViewModel.userFormState.observe(this, Observer{ state ->
            val userFormState = state ?: return@Observer

            registroButton.isEnabled = userFormState.isDataValid

            //muestreo de mensajes de las caja de texto
            if(userFormState.firstNameError !=  null){
                firtName.error = getString(userFormState.firstNameError)
            }
            if(userFormState.lastNameError !=  null){
                lastName.error = getString(userFormState.lastNameError)
            }
            if(userFormState.emailError !=  null){
                email.error = getString(userFormState.emailError)
            }
            if(userFormState.passwordError !=  null){
                password.error = getString(userFormState.passwordError)
            }
        })

        // 4. Observador del resultado de la operación (UserResult)
        // Reacciona al éxito o fallo tras la petición al servidor
        userViewModel.userResult.observe(this, Observer { result ->
            val userResult = result ?: return@Observer

            if (userResult.error != null) {
                // Si hubo un error (ej. conexión o datos inválidos), mostramos el Toast de fallo
                showRegistrationFailed(userResult.error)
            }
            if (userResult.success != null) {
                // Si el registro fue exitoso (Status 201), mostramos bienvenida y cerramos
                updateUiWithUser(userResult.success.first_name)
                setResult(RESULT_OK)
                finish() // Cierra la actividad para volver a la pantalla anterior

                val intent = Intent(this, LoginActivity::class.java) // Cambia 'LoginActivity' por el nombre real de tu clase
                startActivity(intent)
                finish()
            }
        })


        //escuchar los estados de las cajas de texto
        val afertTextChangedListener = object : TextWatcher{
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}
            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

            override fun afterTextChanged(p0: Editable?) {
                userViewModel.userDataChanged(
                    firtName.text.toString(),
                    lastName.text.toString(),
                    email.text.toString(),
                    password.text.toString()
                )
            }

        }

        firtName.addTextChangedListener(afertTextChangedListener)
        lastName.addTextChangedListener(afertTextChangedListener)
        email.addTextChangedListener(afertTextChangedListener)
        password.addTextChangedListener(afertTextChangedListener)

        //observer de registro.
        // 6. Acción del botón de registro
        registroButton.setOnClickListener {
            val userRequest = User(
                first_name = firtName.text.toString(),
                last_name = lastName.text.toString(),
                email = email.text.toString(),
                password = password.text.toString()
            )
            // Llama a la función de registro en el ViewModel (inicia la corrutina)
            userViewModel.register(userRequest)
        }
        //todo fin de oncreate
    }

    /**
     * Muestra un mensaje de éxito al usuario cuando el registro se completa correctamente.
     * @param userName Nombre del usuario registrado para personalizar el saludo.
     */
    private fun updateUiWithUser(userName: String) {
        val welcome = "${getString(R.string.welcome)} $userName"
        Toast.makeText(applicationContext, welcome, Toast.LENGTH_LONG).show()
    }

    /**
     * Muestra un mensaje de error si el proceso de registro falla.
     * @param errorString Identificador del recurso de string con el mensaje de error.
     */
    private fun showRegistrationFailed(errorString: Int) {
        Toast.makeText(applicationContext, errorString, Toast.LENGTH_SHORT).show()
    }
}