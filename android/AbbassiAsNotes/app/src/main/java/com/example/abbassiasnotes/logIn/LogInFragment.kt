package com.example.abbassiasnotes.logIn

import android.content.Context
import androidx.lifecycle.ViewModelProvider
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.view.*
import androidx.fragment.app.Fragment
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.navigation.fragment.NavHostFragment
import com.example.abbassiasnotes.FireBase
import com.example.abbassiasnotes.FireBaseInstance
import com.example.abbassiasnotes.R
import com.example.abbassiasnotes.databinding.LogInFragmentBinding
import com.google.firebase.ktx.Firebase

class LogInFragment : Fragment() {

    private lateinit var binding: LogInFragmentBinding

    private lateinit var viewModel: LogInViewModel


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding =
            DataBindingUtil.inflate(layoutInflater, R.layout.log_in_fragment, container, false)
        viewModel = ViewModelProvider(this).get(LogInViewModel::class.java)

//        viewModel.loginBtnPressed.observe(viewLifecycleOwner, Observer <Boolean>{logInBtnPressed ->
//            if (logInBtnPressed){
//                navigateToUID()
//            }
//        })
        binding.loginFragmentViewModel = viewModel
        binding.lifecycleOwner = viewLifecycleOwner
        viewModel.userStatus.observe(viewLifecycleOwner, Observer<Boolean> { status ->
            if (status) {
                navigateToUID()
            } else {

            }
        })
        setHasOptionsMenu(true)
        screenToNavigateTo()
        return binding.root

    }


    private fun navigateToUID() {
        val preference = requireContext().getSharedPreferences("UID", Context.MODE_PRIVATE)
        val deviceID = preference.getString("deviceID", "") ?: ""
        val retreivedId =
            Settings.Secure.getString(getActivity()!!.contentResolver, Settings.Secure.ANDROID_ID)
        if (deviceID == retreivedId) {
            val action = LogInFragmentDirections.actionLogInFragmentToCameraAccessFragment()
            NavHostFragment.findNavController(this).navigate(action)

        } else {
            val action = LogInFragmentDirections.actionLogInFragmentToUidFragment()
            NavHostFragment.findNavController(this).navigate(action)
            viewModel.setLoginBtnToFalse()
        }

    }

    private fun screenToNavigateTo() {
        val user = FireBaseInstance.auth.currentUser
        if (user !== null) {
            navigateToUID()
        }
    }

}