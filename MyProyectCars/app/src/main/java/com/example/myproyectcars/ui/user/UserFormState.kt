package com.example.myproyectcars.ui.user

data class UserFormState (
    val firstNameError : String? = null,
    val lastNameError: String? = null,
    val passwordError: String? = null,
    val emailError: String? = null,
    val isDataValid: Boolean = false

)