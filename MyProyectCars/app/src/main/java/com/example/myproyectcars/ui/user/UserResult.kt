package com.example.myproyectcars.ui.user

import com.example.myproyectcars.data.user.model.UserResponse


data class UserResult (
    val success: UserResponse? = null,
    val error: Int? = null
)