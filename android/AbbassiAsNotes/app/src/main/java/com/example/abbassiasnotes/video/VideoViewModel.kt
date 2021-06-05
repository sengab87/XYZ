package com.example.abbassiasnotes.video

import androidx.databinding.Observable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class VideoViewModel(passedUrl: String) : ViewModel(),Observable {
    private val _url = MutableLiveData<String>()
    val url: LiveData<String> = _url

    init{
        _url.value = passedUrl
    }

    override fun addOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {
//        TODO("Not yet implemented")
    }

    override fun removeOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {
//        TODO("Not yet implemented")
    }
}