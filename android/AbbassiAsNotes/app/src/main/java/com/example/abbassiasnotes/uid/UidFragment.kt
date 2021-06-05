package com.example.abbassiasnotes.uid


import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.telephony.TelephonyManager
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.addCallback
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat.getSystemService
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.abbassiasnotes.R
import com.example.abbassiasnotes.databinding.UidFragmentBinding


class UidFragment : Fragment() {

    private lateinit var binding: UidFragmentBinding


    private lateinit var viewModel: UidViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val id: String = Settings.Secure.getString(getActivity()!!.contentResolver, Settings.Secure.ANDROID_ID)
        binding = DataBindingUtil.inflate(layoutInflater, R.layout.uid_fragment,container,false)
        viewModel = ViewModelProvider(this,UidViewModelFactory(id,requireContext())).get(UidViewModel::class.java)
        binding.uidViewModel = viewModel
        binding.lifecycleOwner = viewLifecycleOwner

        val callback = requireActivity().onBackPressedDispatcher.addCallback(this) {

        }
        val result = requireContext().getSharedPreferences("UID", Context.MODE_PRIVATE).getString("deviceID","")
        Log.i("Resu",result.toString())
        return binding.root
    }


}