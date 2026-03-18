package com.example.myproyectcars.ui.user

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.myproyectcars.data.login.datasource.LoginDataSource
import com.example.myproyectcars.data.login.repository.LoginRepository
import com.example.myproyectcars.data.user.datasource.UserDataSource
import com.example.myproyectcars.data.user.repository.UserRepository
import com.example.myproyectcars.ui.login.LoginViewModel

class UserViewModelFactory(private val context: Context) : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(UserViewModel::class.java)) {
            return UserViewModel(
                userRepository = UserRepository(
                    dataSource = UserDataSource(context)
                )
            ) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}