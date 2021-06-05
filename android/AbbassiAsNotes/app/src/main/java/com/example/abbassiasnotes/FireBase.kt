package com.example.abbassiasnotes

import android.util.Log
import android.widget.Toast
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase

class FireBase {

    companion object {
        val instance = Firebase.auth
    }
    fun checkCurrentIsLoggedIn(){
        val currentUser = instance.currentUser
        if (currentUser === null){

        }else{

        }

    }
    fun createUser(email: String, password: String, status:(Boolean) -> Unit ){
        instance.createUserWithEmailAndPassword(email, password).addOnCompleteListener { task ->
            if (task.isSuccessful){
                //// create user
                status(true)
            }else{
                ////
                status(false)

            }
        }
    }


}


