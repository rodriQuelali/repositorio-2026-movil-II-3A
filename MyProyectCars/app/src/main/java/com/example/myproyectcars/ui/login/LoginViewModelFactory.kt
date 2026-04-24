package com.example.myproyectcars.ui.login

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.myproyectcars.data.login.datasource.LoginDataSource
import com.example.myproyectcars.data.login.repository.LoginRepository
import com.example.myproyectcars.utils.NotificationHelper

/**
 * ViewModel provider factory to instantiate LoginViewModel.
 * Required given LoginViewModel has a non-empty constructor
 */
class LoginViewModelFactory(private val context: Context) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(LoginViewModel::class.java)) {
            return LoginViewModel(
                loginRepository = LoginRepository(
                    dataSource = LoginDataSource(context)
                ),
                notificationHelper = NotificationHelper(context)
            ) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}