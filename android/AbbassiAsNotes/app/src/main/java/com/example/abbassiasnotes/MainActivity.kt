package com.example.abbassiasnotes


import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import com.example.abbassiasnotes.logIn.LogInFragment
import com.example.abbassiasnotes.uid.UidFragment


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_item, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        val navController = findNavController(R.id.nav_host_fragment)

        return when(item.itemId) {
            R.id.device -> {
                navController.navigate(R.id.cameraAccessFragment)
                true
            }
            R.id.Codes ->{
                navController.navigate(R.id.uidFragment)
                true
            }
            else -> return super.onOptionsItemSelected(item)
        }

    }

}