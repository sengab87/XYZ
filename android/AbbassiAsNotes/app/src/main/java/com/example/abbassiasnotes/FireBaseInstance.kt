package com.example.abbassiasnotes

import android.util.Log
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.DocumentSnapshot
import com.google.firebase.firestore.FirebaseFirestoreException
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.FirebaseStorage
import com.google.firebase.storage.ktx.storage

object FireBaseInstance {
    val auth = Firebase.auth
    val db = Firebase.firestore
    val storageRef = Firebase.storage.reference

    fun createUser(email: String, password: String, status:(Boolean) -> Unit){
        auth.createUserWithEmailAndPassword(email, password).addOnCompleteListener { task ->
            if (task.isSuccessful){
                status(true)
            }else {
                status(false)
            }
        }

    }
    fun verifyUUID(uuid: String,deviceId: String, Status: (Boolean) -> Unit) {


        val docRef = db.collection("UUID").document(uuid)
        val userRef = db.collection("users").document(auth.currentUser!!.uid.toString())

        db.runTransaction { transaction ->
            val docUUID: DocumentSnapshot = transaction.get(docRef)
            val typeOfBook = docUUID.data?.get("Book")

            if (typeOfBook != null){
                transaction.delete(docRef)
                val book = hashMapOf(
                    "Books" to hashMapOf(
                        typeOfBook to typeOfBook.toString(),
                        "UUID" to uuid
                    ),
                    "deviceId" to deviceId,
                    "school" to "EBIS"
                )
                transaction.set(userRef,book)
            }
            else{
                throw FirebaseFirestoreException("Population too high",
                    FirebaseFirestoreException.Code.ABORTED)
            }
        }.addOnSuccessListener { result ->
            Status(true)

        }.addOnFailureListener { e ->
            Status(false)
        }
    }
    fun downloadUrl(Url:(String)->Unit){
        storageRef.child("P1NOTES/RPReplay_Final1619124054.mp4").downloadUrl.addOnSuccessListener {url->
            // Got the download URL for 'users/me/profile.png'
            Log.i("URIss",url.toString())
            Url(url.toString())
        }.addOnFailureListener {
            // Handle any errors
        }

    }
}