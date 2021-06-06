//
//  UUIDViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/8/21.
//

import UIKit
import Firebase
import FirebaseAuth
import iOSDropDown

class UUIDViewController:  ConnectionStatusViewController, UITextFieldDelegate {
   
    
    @IBOutlet weak var schoolDropDown: DropDown!
    @IBOutlet weak var UUIDTextField: UITextField!
    @IBOutlet weak var NextBtn: UIButton!
    var selectedText = String()
    @IBOutlet weak var schoolError: UILabel!
    @IBOutlet weak var UidView: UIView!
    @IBOutlet weak var UidError: UILabel!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        NextBtn.addTarget(self, action: #selector(NextBtnPressed(_:)), for: .touchDown)
        UUIDTextField.delegate = self
        schoolDropDown.selectedRowColor = #colorLiteral(red: 0.3242118955, green: 0.5099019408, blue: 0.9605500102, alpha: 1)
        schoolDropDown.optionArray = ["EBIS", "BSC", "CAPITAL","SLS","OTHER"]
        schoolDropDown.didSelect{(selectedText , index ,id) in
            self.selectedText = selectedText
            self.schoolError.isHidden = true
            self.UidError.isHidden = true
            
        }
        subscribeToShowKeyboardNotifications()

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.removeOverlay()
    }
    
    @objc private func NextBtnPressed(_: UIButton){
        let uuidText = UUIDTextField.text!
        /// Schoool //
        self.UidError.isHidden = false

        
        let status = validateInput(schoolName: self.selectedText, uid: uuidText)
        if (status.0){
            self.schoolError.isHidden = false
        }
        if(status.1){
            self.UidError.isHidden = false
        }
        if (!status.0 && !status.1){
            
              self.view.endEditing(true)

                self.addTranstion()
            UsersWebServices.instance.VerifyUUID(schoolName: self.selectedText, uuid: uuidText) { (status) in
                    if (status){
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "qrcode", sender: nil)
                        }

                    } else {
                        DispatchQueue.main.async {
                            self.UidError.isHidden = false
                            self.removeOverlay()
                        }
                    }
                }
        }
    }
    private func currentlyEditedTextField(textField: UITextField){
            UidView.backgroundColor = #colorLiteral(red: 0.3242118955, green: 0.5099019408, blue: 0.9605500102, alpha: 1)
    }
    private func stopEditingAllTextFields(){
        UidView.backgroundColor = #colorLiteral(red: 0.7675911784, green: 0.7676092982, blue: 0.7675995827, alpha: 1)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        UidError.isHidden = true
        schoolError.isHidden = true
        return true
    }
     func textFieldDidBeginEditing(_ textField: UITextField) {
        UidError.isHidden = true
        schoolError.isHidden = true
        currentlyEditedTextField(textField: textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        stopEditingAllTextFields()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UUIDTextField.resignFirstResponder()
        return true
    }
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)

    }
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonBottomConstraint.constant = 32
    }
    @objc func keyboardWillShow(_ notification: Notification) {
            let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            let keyboardHeight = keyboardSize.cgRectValue.height
            buttonBottomConstraint.constant =  keyboardHeight + 8
    }
    private func validateInput(schoolName: String, uid: String) -> (Bool,Bool){
        let schoolStatus = schoolName.contains(" ") || schoolName.isEmpty
        let uidStatus = uid.contains(" ") || uid.isEmpty
        return (schoolStatus,uidStatus)
        
    }
//    UsersWebServices.instance.VerifyUUID(uuid: uuidText) { (status) in
//        if (status){
//            self.performSegue(withIdentifier: "qrcode", sender: nil)
//        }
//    }


}
