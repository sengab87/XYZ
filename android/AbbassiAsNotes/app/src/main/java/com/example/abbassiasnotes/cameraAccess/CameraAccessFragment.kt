package com.example.abbassiasnotes.cameraAccess

import android.Manifest
import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.NavHostFragment
import com.example.abbassiasnotes.R
import com.example.abbassiasnotes.databinding.CameraAccessFragmentBinding
import com.google.zxing.integration.android.IntentIntegrator
import org.json.JSONException
import org.json.JSONObject


class CameraAccessFragment : Fragment() {

    val CAMERA_RQ = 102


    private lateinit var viewModel: CameraAccessViewModel
    private lateinit var binding: CameraAccessFragmentBinding


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = DataBindingUtil.inflate(layoutInflater,R.layout.camera_access_fragment,container,false)
        viewModel = ViewModelProvider(this).get(CameraAccessViewModel::class.java)
        binding.cameraAccessFragmentViewModel = viewModel
        binding.lifecycleOwner = viewLifecycleOwner
        viewModel.cameraBtn.observe(viewLifecycleOwner, Observer<Boolean> { status ->
            if (status) {

                accessCamera(android.Manifest.permission.CAMERA, "camera",CAMERA_RQ)
                val requiredPermission = Manifest.permission.CAMERA
                val checkVal = requireContext()
                    .checkCallingOrSelfPermission(requiredPermission)
               if (checkVal == 0){
                   val scanner = IntentIntegrator.forSupportFragment(this)
                   scanner.setBeepEnabled(false)
                   scanner.setCameraId(0)
                   scanner.setPrompt("SCAN")
                   scanner.setBarcodeImageEnabled(false)
                   scanner.initiateScan()
                }
                else{

                }
            } else {

            }
        })

        return binding.root
    }


    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?
    ) {
        val result = IntentIntegrator.parseActivityResult(requestCode, resultCode, data)
        if (result != null) {
            if (result.contents == null) {
                Toast.makeText(context, "Scanning failed", Toast.LENGTH_SHORT).show()
            } else {

                val content = result.contents.toString()
                Log.i("url",content)
                navigateToVideoScreen(result.contents.toString())
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        fun innerCheck(name: String){
            if (grantResults.isEmpty() || grantResults[0] != PackageManager.PERMISSION_GRANTED){
                Toast.makeText(requireContext(),"$name permission refused",Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(requireContext(),"$name permission granted",Toast.LENGTH_SHORT).show()
            }
        }
        when(requestCode) {
            CAMERA_RQ -> innerCheck("camera")
        }
    }
    private fun accessCamera(permission:String, name: String, requestCode: Int){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
            when{
                ContextCompat.checkSelfPermission(requireContext(),permission) == PackageManager.PERMISSION_GRANTED -> {

                }
                shouldShowRequestPermissionRationale(permission) -> showDialog(permission,name,requestCode)
                else -> ActivityCompat.requestPermissions(requireActivity(), arrayOf(permission),requestCode)
            }
        }

    }
    private fun showDialog(permission: String, name: String, requestCode: Int){
        val builder = AlertDialog.Builder(requireContext())
        builder.apply{
            setMessage("Permission to your $name is required to use this app")
            setTitle("Permission Require")
            setPositiveButton("OK"){
                dialog,which ->
                ActivityCompat.requestPermissions(requireActivity(), arrayOf(permission),requestCode)
            }
        }
        val dialog: AlertDialog = builder.create()
        dialog.show()
    }

    private fun navigateToVideoScreen(urlP: String){
        val action = CameraAccessFragmentDirections.actionCameraAccessFragmentToVideoFragment(urlP)
        action.url = urlP
        NavHostFragment.findNavController(this).navigate(action)

    }
}