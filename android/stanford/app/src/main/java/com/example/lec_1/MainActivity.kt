package com.example.lec_1

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.Toast
import kotlin.random.Random


/// Activities are single screen of UI in app
/// view visible onscreen items widgets and layout
// widget GUI control such as button
// layout invisible container to position / size widgets
/// events action that occurs when user interact with widget
/// action Bar top menu of common action
/// notification area top system menu

class MainActivity : AppCompatActivity() {

    private var points = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        title = "Berkeley"
        val leftButton: Button = findViewById(R.id.leftButton)
        leftButton.setOnClickListener{

            val r = Random
            val num = r.nextInt(100)
            leftButton.text = "$num"
            Toast.makeText(this,"buttonOne Clicked", Toast.LENGTH_SHORT).show()
        }
        val rightButton: Button = findViewById(R.id.rightButton)
        rightButton.setOnClickListener{
            val r = Random
            val num = r.nextInt(100)
            Toast.makeText(this,"button two Clicked", Toast.LENGTH_SHORT).show()
            rightButton.text = "$num"
            
        }
    }


}
