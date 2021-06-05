//
//  SignUpViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/8/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: ConnectionStatusViewController, UITextFieldDelegate {
    @IBOutlet weak var EmailAddress: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet var EmailAddressView: UIView!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        Password.isSecureTextEntry =  true
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeOverlay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let status = UserDefaults.standard.value(forKey: "account") as? String
        print(status," LOCKING ")
        if (status != "locked"){
            EmailAddress.delegate = self
            Password.delegate = self
            SignUpBtn.addTarget(self, action: #selector(SignUpBtnPressed(_:)), for: .touchDown)
            showPasswordBtn.addTarget(self, action: #selector(ToggleShowPassword(_:)), for: .touchDown)
            subscribeToShowKeyboardNotifications()
        } else {
            SignUpBtn.alpha = 0.2
            SignUpBtn.isEnabled = false
        }
        // Do  any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        emailError.isHidden = true
        passwordError.isHidden = true
        return true
    }
     func textFieldDidBeginEditing(_ textField: UITextField) {
        emailError.isHidden = true
        passwordError.isHidden = true
       currentlyEditedTextField(textField: textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        stopEditingAllTextFields()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func ToggleShowPassword(_ button: UIButton){
        if (Password.isSecureTextEntry){
            Password.isSecureTextEntry = false
            showPasswordBtn.setImage(#imageLiteral(resourceName: "passwordseen"), for: .normal)
        }else{
            Password.isSecureTextEntry = true
            showPasswordBtn.setImage(#imageLiteral(resourceName: "showpassword"), for: .normal)
        }
    }
    @objc private func SignUpBtnPressed(_: UIButton){
        let email = EmailAddress.text!
        let password = Password.text!
        let validationResult = validateInput(email: email, pass: password)
        if (!validationResult.0 && !validationResult.1){
            /// Submit Resuquest
            self.view.endEditing(true)
            addTranstion()
            submitUserToFireBase(email: email, password: password)
        }else{
            if (validationResult.0){
                //// email eeerrr
                emailError.isHidden = false
            }
            if (validationResult.1) {
                //// password error
                passwordError.isHidden = false
            }
        }

    }
    @objc func keyboardWillShow(_ notification: Notification) {
            let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            let keyboardHeight = keyboardSize.cgRectValue.height
            buttonBottomConstraint.constant =  keyboardHeight - 28
    }
    private func currentlyEditedTextField(textField: UITextField){
        if (textField == Password){
            PasswordView.backgroundColor = #colorLiteral(red: 0.3260192871, green: 0.5101656318, blue: 0.95927912, alpha: 1)
            EmailAddressView.backgroundColor = #colorLiteral(red: 0.7675911784, green: 0.7676092982, blue: 0.7675995827, alpha: 1)
        
        }else {
            EmailAddressView.backgroundColor = #colorLiteral(red: 0.3242118955, green: 0.5099019408, blue: 0.9605500102, alpha: 1)
            PasswordView.backgroundColor = #colorLiteral(red: 0.7675911784, green: 0.7676092982, blue: 0.7675995827, alpha: 1)
        }
    }
    private func stopEditingAllTextFields(){
        EmailAddressView.backgroundColor = #colorLiteral(red: 0.7675911784, green: 0.7676092982, blue: 0.7675995827, alpha: 1)
        PasswordView.backgroundColor = #colorLiteral(red: 0.7675911784, green: 0.7676092982, blue: 0.7675995827, alpha: 1)
    }
    

        @objc func keyboardWillHide(_ notification: Notification) {
            buttonBottomConstraint.constant = 32
        }

        func subscribeToShowKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)

        }
    private func validateInput(email: String, pass: String) -> (Bool,Bool) {
        let emailStatus = email.contains(" ") || email.count < 1 || !email.contains("@")
        let passStatus =  pass.contains(" ") || pass.count < 6
        return(emailStatus,passStatus)
    }
    private func submitUserToFireBase(email:String, password: String){
        UsersWebServices.instance.signInUsers(email: email, password: password) { (status) in
                   //// User Not Available in db
                   if (status == nil){
                       /// Create User
                       UsersWebServices.instance.CreateUser(email: email, password: password) { (result) in
                           //// UserCreated
                           if (result){
                            
                               
                               self.performSegue(withIdentifier: "UID", sender: nil)
                           }
                           //// Error Creating User
                       }
                   }else{
                       print(UIDevice.current.identifierForVendor?.uuidString)
                       //// User Available in Database
                       /// NEED TO CHECK so to segue in another part
                       ///
                       let user = Auth.auth().currentUser?.uid
                       /// check if they have same device id
                       UsersWebServices.instance.checkUser(uid: user!) { (document) in
                           if (document == nil)
                           {
                               self.performSegue(withIdentifier: "UID", sender: nil)
                               /// GO TO UID ///
       
                               /// NEED TESTING ///
                           }
                           if let doc = document {
                               guard let deviceId = doc.data()?["deviceId"] as? String else{
                                return self.removeOverlay()
                               }
                               if (deviceId == UIDevice.current.identifierForVendor?.uuidString){
                                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                   let viewController = storyboard.instantiateViewController(identifier: "Video") as! CameraViewController
                                   let navController = storyboard.instantiateViewController(identifier: "UUIDNav") as! UINavigationController
                                   navController.viewControllers = [viewController]
                                   UIApplication.shared.windows.first?.rootViewController = navController
                                   UIApplication.shared.windows.first?.makeKeyAndVisible()
                               } else {
                                   print(deviceId, " dev ", UIDevice.current.identifierForVendor?.uuidString)
                                   
                                
                                self.removeOverlay()
                                
                                
                                   print("lock Account")
                               }
       
                           }
                       }       
                   }
               }
    }
}
