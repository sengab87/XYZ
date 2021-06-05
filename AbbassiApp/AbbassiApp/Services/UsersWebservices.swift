//
//  UsersWebservices.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/8/21.
//

import Foundation
import Firebase


class UsersWebServices{
    static let instance = UsersWebServices()
    let db = Firestore.firestore()
    
    /// Sign In Users
    
    func signInUsers(email: String, password: String, handler: @escaping(_ status: AuthDataResult?)->()){
        Auth.auth().signIn(withEmail: email, password: password) { (AuthResult, Error) in
            if (AuthResult == nil){
                handler(nil)
            }else{
                handler(AuthResult)
            }
        }
    }
    
    func CreateUser(email: String, password: String, handler: @escaping(_ status: Bool)->()){
        Auth.auth().createUser(withEmail: email, password: password) { (AuthResult, Error) in
            /// successfully created user
            if (Error == nil){
                UserDefaults.standard.setValue(true, forKey: "sign")
                handler(true)
            }
            /// failed to create user
            else{
                handler(false)
            }
        }
    }
    
    func VerifyUUID(schoolName: String, uuid: String, handler: @escaping(_ status: Bool)->()){
        
        let docRef = db.collection("UUID").document(uuid)
        let usersRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        var currentDevId = String()
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let docUUID : DocumentSnapshot
            let users : DocumentSnapshot
            do {
                try docUUID = transaction.getDocument(docRef)
                currentDevId = docUUID.data()?["deviceId"] as! String
            }catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            guard let docStatus = docUUID.data()?["Book"] else {
                let error = NSError(
                          domain: "AppErrorDomain",
                          code: -1
                      )
                      errorPointer?.pointee = error
                      return nil
            }
            if (currentDevId != "null") {
                let error = NSError(
                          domain: "AppErrorDomain",
                          code: -1
                      )
                      errorPointer?.pointee = error
                      return nil
            }
            let bookName = docUUID.data()?["Book"] as! String
            let newObj = ["Book":bookName,
                              "deviceId":UIDevice.current.identifierForVendor?.uuidString,
                              "userId":Auth.auth().currentUser?.uid
                ]
            transaction.updateData(newObj, forDocument: docRef)
            transaction.setData([
                                     bookName : uuid,
                                    "deviceId": UIDevice.current.identifierForVendor?.uuidString,
                                    "School": schoolName], forDocument: usersRef)
            UserDefaults.standard.setValue(Auth.auth().currentUser?.uid, forKey: "UID")
            return nil
        })
        { (object, error) in
            if let error = error {
                print(error," EROR")
                handler(false)
            } else {
               handler(true)
            }
        }
        
    }
    func checkUser(uid: String, handler: @escaping (_ status: DocumentSnapshot?) ->()){
        db.collection("users").document(uid).getDocument { (document, error) in
            if let document = document, document.exists{
                handler(document)
            }else{
             handler(nil)
            }
        }
    }
    func checkUuidIsValid(uuid:String, handler:@escaping (_ status: Bool, _ value: String?) -> ()){
        db.collection("UUID").document(uuid).getDocument { documentSnap, error in
            if(error == nil){
                guard let docUUID = documentSnap?.data()?["Book"] as? String,
                      let docUUIDStatus = documentSnap?.data()?["deviceId"] as? String
                else{
                    handler(false,"Can't find UUID")
                    return
                }
                if(docUUIDStatus == "null")
                {
                    handler(true,docUUID)
                }
                else {
                    handler(false,"Can't find UUID")
                }
            }else {
                handler(false,"Can't find UUID")
            }
        }
    }
    func getUserSchool(handler:@escaping(_ status:String?)->()){
        db.collection("users").document(Auth.auth().currentUser!.uid).getDocument { docSnap, error in
            print(docSnap?.data()?["School"], "POP" ,error, "popo")
            if (error == nil){
                guard let school = docSnap?.data()?["School"] as? String
                else{ return }
                handler(school)
            }
        }
    }
    func getSchoolCurrentPage(school:String, notes:String, page: String, handler: @escaping (_ status: Bool)->()){
        db.collection("schools").document(school).getDocument { docSnap, error in
            if (error == nil){
                guard let currentDoc = docSnap?.data()![notes]
                else { return }
                handler(true)
            }else {
                handler(false)
            }
        }
    }
    func getCurrentUserNotes(uuid: String, userId:String, docType:String, handler: @escaping (_ status: Bool)->()){
        var dict = [String:Any]()
        dict[docType] = uuid
        db.collection("users").document(userId).getDocument { docSnap, error in
            if (error == nil){
                guard let snap = docSnap?.data()
                else {
                    return
                }
                for(key,value) in snap {
                    if (key == docType){
                        handler(false)
                        return
                    }else {
                       dict[key]=value
                    }
                }
//                "deviceId":UIDevice.current.identifierForVendor?.uuidString,
//                "userId":Auth.auth().currentUser?.uid
                self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                    self.db.collection("users").document(userId).setData(dict)
                    self.db.collection("UUID").document(uuid).updateData([
                            "Book":docType,
                            "deviceId":UIDevice.current.identifierForVendor?.uuidString,
                            "userId":Auth.auth().currentUser?.uid])
                    return nil
                }){ (object, error) in
                    if let error = error {
                        print(error," EROR")
                        handler(false)
                    } else {
                       handler(true)
                    }
                }
                
            }
            handler(false)
        }
    }
}

