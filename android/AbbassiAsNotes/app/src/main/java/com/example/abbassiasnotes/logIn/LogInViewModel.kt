package com.example.abbassiasnotes.logIn

import android.util.Log
import androidx.databinding.Bindable
import androidx.databinding.Observable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.abbassiasnotes.FireBase
import com.example.abbassiasnotes.FireBaseInstance

class LogInViewModel : ViewModel(), Observable {

    @Bindable
    val loginBtnPressed = MutableLiveData<Boolean>()
    @Bindable
    val emailText = MutableLiveData<String>()
    @Bindable
    val passText = MutableLiveData<String>()

    private val _userStatus = MutableLiveData<Boolean>()
    val userStatus:LiveData<Boolean> = _userStatus

    fun loginBtnPressed(){

        if (emailText.value.isNullOrEmpty() || passText.value.isNullOrEmpty()){
            Log.i("Email", "1")
            Log.i("Pass","2")
        }else{
            loginBtnPressed.value = true
            val email = emailText.value.toString()
            val pass = passText.value.toString()
            FireBaseInstance.createUser(email,pass) {
                status ->
                if (status){
                    _userStatus.value = true
                }else {
                    _userStatus.value = true
                    // NOT UPDATE UI
                }
            }
        }

    }

    fun setLoginBtnToFalse(){
        loginBtnPressed.value = false
    }

    override fun addOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {
//        TODO("Not yet implemented")
    }

    override fun removeOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {
//        TODO("Not yet implemented")
    }
}