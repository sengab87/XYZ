package com.example.abbassiasnotes.uid


import android.content.Context
import android.util.Log
import android.widget.RadioButton
import android.widget.RadioGroup
import android.widget.Toast
import androidx.databinding.Bindable
import androidx.databinding.Observable
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.abbassiasnotes.FireBaseInstance


class UidViewModel(id: String, context: Context) : ViewModel(), Observable {
    @Bindable
    val uidText = MutableLiveData<String>()
    private var schoolName = String()
    private var deviceId = String()
    private var context = context
    private val preferences = context.getSharedPreferences("UID", Context.MODE_PRIVATE)
    init{
        deviceId = id
        schoolName = "Ebis"
    }

    override fun addOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {

    }

    override fun removeOnPropertyChangedCallback(callback: Observable.OnPropertyChangedCallback?) {

    }

    fun SubmitBtnPressed(){
        FireBaseInstance.verifyUUID(uidText.value.toString(), deviceId) { status ->
            if (status) {
                preferences.edit().putString("deviceID", deviceId).commit()
            } else {
                Toast.makeText(context,"Please Enter a valid UID",Toast.LENGTH_SHORT).show()
            }
        }

    }
    fun RadioButtonPressed(radioGroup: RadioGroup, id:Int){
        val ids = radioGroup.findViewById<RadioButton>(id)
        schoolName = ids.text.toString()
    }
}