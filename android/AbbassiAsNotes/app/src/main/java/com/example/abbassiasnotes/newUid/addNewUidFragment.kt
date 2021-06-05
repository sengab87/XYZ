package com.example.abbassiasnotes.newUid

import androidx.lifecycle.ViewModelProvider
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.abbassiasnotes.R

class addNewUidFragment : Fragment() {

    companion object {
        fun newInstance() = addNewUidFragment()
    }

    private lateinit var viewModel: AddNewUidViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.add_new_uid_fragment, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProvider(this).get(AddNewUidViewModel::class.java)
        // TODO: Use the ViewModel
    }

}