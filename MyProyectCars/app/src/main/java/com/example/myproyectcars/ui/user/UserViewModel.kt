package com.example.myproyectcars.ui.user


import android.util.Patterns
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.myproyectcars.R
import com.example.myproyectcars.data.login.model.Result
import com.example.myproyectcars.data.user.model.User
import com.example.myproyectcars.data.user.repository.UserRepository
import kotlinx.coroutines.launch

class UserViewModel(private val userRepository: UserRepository): ViewModel() {

    //validacion
    private val _userForm = MutableLiveData<UserFormState>()
    val userFormState: LiveData<UserFormState> = _userForm

    //resultado
    private val _userResult = MutableLiveData<UserResult>()
    val userResult: LiveData<UserResult> = _userResult

    fun register(user: User){
        viewModelScope.launch {
            val result = userRepository.register(user)
            if(result is Result.Success){
                _userResult.value = UserResult(success = result.data)
            }else{
                _userResult.value = UserResult(error = R.string.error_register)
            }
        }
    }

    //validacion funcion
    fun userDataChanged(firstName: String, lastname: String, email: String, password: String){
        if(!isFirtsNameValid(firstName)){
            _userForm.value = UserFormState(firstNameError = R.string.error_firstName)
        }

    }

    private fun  isFirtsNameValid(name: String):Boolean = name.isNotBlank()
    private fun  isLastNameValid(name: String):Boolean = name.isNotBlank()
    private fun  isEmailValid(email: String):Boolean = Patterns.EMAIL_ADDRESS.matcher(email).matches()
    private fun  isPasswordValid(password: String):Boolean = password.length > 5

}