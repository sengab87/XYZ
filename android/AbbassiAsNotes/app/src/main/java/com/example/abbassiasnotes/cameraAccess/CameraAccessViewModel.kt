package com.example.abbassiasnotes.cameraAccess

import androidx.databinding.Observable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModel

class CameraAccessViewModel : ViewModel(), Observable {
    // TODO: Implement the ViewModel
    private val _cameraBtn = MutableLiveData<Boolean>()
    val cameraBtn:LiveData<Boolean> = _cameraBtn




    fun cameraBtnPressed(){
        _cameraBtn.value = true

    }

    override fun addOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {
//        TODO("Not yet implemented")
    }

    override fun removeOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {
//        TODO("Not yet implemented")
    }
}