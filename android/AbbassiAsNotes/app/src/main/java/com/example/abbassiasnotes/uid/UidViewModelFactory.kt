package com.example.abbassiasnotes.uid

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

class UidViewModelFactory(private val id: String, private val context: Context):ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(UidViewModel::class.java)) {
            return UidViewModel(id, context) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}