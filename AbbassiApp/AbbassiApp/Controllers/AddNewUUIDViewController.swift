//
//  AddNewUUIDViewController.swift
//  AbbassiApp
//
//  Created by Ahmed Sengab on 5/27/21.
//

import UIKit
import Firebase
import PMAlertController

class AddNewUUIDViewController: ConnectionStatusViewController, UITextFieldDelegate {

    @IBOutlet weak var UidError: UILabel!
    @IBOutlet weak var UidView: UIView!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var FinishBtn: UIButton!
    @IBOutlet weak var addUUIDText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToShowKeyboardNotifications()
        FinishBtn.addTarget(self, action: #selector(FinishBtnPressed(_:)), for: .touchDown)
        addUUIDText.delegate = self
    }
    @objc private func FinishBtnPressed(_ sender: UIButton){
        let status = validateInput(uuid: addUUIDText.text!)
        if (status){
            UidError.isHidden = false
        } else {
            checkUUID(uuidText: addUUIDText.text!)
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        removeOverlay()
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
    private func currentlyEditedTextField(textField: UITextField){
            UidView.backgroundColor = #colorLiteral(red: 0.3242118955, green: 0.5099019408, blue: 0.9605500102, alpha: 1)
    }
    private func stopEditingAllTextFields(){
        UidView.backgroundColor = #colorLiteral(red: 0.7675911784, green: 0.7676092982, blue: 0.7675995827, alpha: 1)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        UidError.isHidden = true
        return true
    }
     func textFieldDidBeginEditing(_ textField: UITextField) {
        UidView.backgroundColor = #colorLiteral(red: 0.3242118955, green: 0.5099019408, blue: 0.9605500102, alpha: 1)
        UidError.isHidden = true
        currentlyEditedTextField(textField: textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        stopEditingAllTextFields()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addUUIDText.resignFirstResponder()
        return true
    }
    private func validateInput(uuid: String) -> Bool {
        let uuidText = uuid.contains(" ") || uuid.isEmpty
        return (uuidText)
    }
    private func checkUUID(uuidText: String) {
        self.view.endEditing(true)
        addTranstion()
        UsersWebServices.instance.checkUuidIsValid(uuid: uuidText) { status, value in
            if (status){
                
                UsersWebServices.instance.getCurrentUserNotes(uuid: uuidText, userId: Auth.auth().currentUser!.uid,docType: value!) { currentUIDStatus in
                    if(currentUIDStatus){
                        self.removeOverlay()
                        self.UidError.isHidden = true
                        self.ConfirmAdd()
                        
                    }else {
                        self.removeOverlay()
                        self.UidError.isHidden = false
                    }
                }
            }else {
                self.removeOverlay()
                self.UidError.isHidden = false
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
    }
    private func ConfirmAdd(){
            let alertVC = PMAlertController(title: "UID Status", description: "You have successfully added new UID", image: #imageLiteral(resourceName: "tick"), style: .alert)

            alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
                self.navigationController?.popViewController(animated: true)
                    }))

            self.present(alertVC, animated: true, completion: nil)
        
    }

}
