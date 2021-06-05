package com.example.abbassiasnotes.video

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

class VideoViewModelFactory(private val passedUrl: String): ViewModelProvider.Factory {

    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(VideoViewModel::class.java)) {
            return VideoViewModel(passedUrl) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }

}