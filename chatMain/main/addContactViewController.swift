//
//  addContactViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 8/19/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class addContactViewController: connectionStatus , UITextFieldDelegate,mainProtocol{

    ///////// First and last Name Text Fields /////////
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    ////////////////////////////////////////////////////
    
    ///// First phone /////////////////
    @IBOutlet weak var phoneOneTextField: UITextField!
    @IBOutlet weak var delButtonPhoneOne: UIButton!
    @IBOutlet weak var phoneOneEdit: UIView!
    @IBOutlet weak var phoneOneView: UIView!
    @IBOutlet weak var horViewPhoneOne: UIView!
    ///////////////////////////////////////
    
    //////// Second phone ////////////////
    @IBOutlet weak var phoneTwoTextField: UITextField!
    @IBOutlet weak var delButtonPhoneTwo: UIButton!
    @IBOutlet weak var phoneTwoEdit: UIView!
    @IBOutlet weak var phoneTwoView: UIView!
    @IBOutlet weak var horViewPhoneTwo: UIView!
    /////////////////////////////////////////
    
    /////// Third Phone ///////////////////////
    @IBOutlet weak var phoneThreeTextField: UITextField!
    @IBOutlet weak var delButtonPhoneThree: UIButton!
    @IBOutlet weak var phoneThreeEdit: UIView!
    @IBOutlet weak var phoneThreeView: UIView!
    @IBOutlet weak var horViewPhoneThree: UIView!
    ///////////////////////////////////////////
    
    //////// mainProperties /////////////
    @IBOutlet weak var horView: UIView!
    @IBOutlet weak var verView: UIView!
    @IBOutlet weak var addButton: UIView!
    @IBOutlet weak var addPhoneView: UIView!
    var delegate : mainProtocol?
    var doneButton = UIBarButtonItem()
    var cancelBarButton = UIBarButtonItem()
    var count = 0
    var doneBarButton = UIBarButtonItem()
    var cancelBarTextButton = UIBarButtonItem()
    /////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navSettings()
        createToolBar()
        creatTextToolBar()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            AppUtility.lockOrientation(.portrait)
            // Or to rotate and lock
            // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
            
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    func creatTextToolBar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        cancelBarTextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.cancelTextBarClicked))
        cancelBarTextButton.tintColor = UIColor(red: red, green:  green, blue: blue, alpha: 1)
        toolBar.setItems([cancelBarTextButton], animated: false)
        firstNameTextField.inputAccessoryView = toolBar
        lastNameTextField.inputAccessoryView = toolBar
    }
    func createToolBar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        doneBarButton.tintColor = UIColor(red: red, green:  green, blue: blue, alpha: 1)
        doneBarButton.isEnabled = false
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.cancelClicked))
        cancelButton.tintColor = UIColor(red: red, green:  green, blue: blue, alpha: 1)
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, flexButton, doneBarButton], animated: false)
        phoneOneTextField.inputAccessoryView = toolBar
        phoneTwoTextField.inputAccessoryView = toolBar
        phoneThreeTextField.inputAccessoryView = toolBar
    }
    
    func navSettings()
    {
        cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneButtonPressed))
        cancelBarButton.tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        doneButton.tintColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "New Contact"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = doneButton
        self.doneButton.isEnabled = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            if (touch.view == addPhoneView || touch.view == horView || touch.view == verView || touch.view == addButton)
            {
                print("yo")
                addPhone()
            }
            if (touch.view == phoneOneEdit || touch.view == horViewPhoneOne)
            {
                phoneNumOne()
            }
            if (touch.view == phoneTwoEdit || touch.view == horViewPhoneTwo)
            {
                phoneNumTwo()
            }
            
            if (touch.view == phoneThreeEdit || touch.view == horViewPhoneThree)
            {
                phoneNumThree()
            }
        }
    }
    func addPhone()
    {
        let mainWidth = addPhoneView.frame.width
        let xcoor = addPhoneView.frame.minX
        let ycoor = addPhoneView.frame.minY
        let mainHeight = addPhoneView.frame.height
        print(ycoor)
        if (count < 3)
        {
            count = count + 1
            addPhoneView.frame = CGRect(x: xcoor, y: ycoor+45 + 5, width: mainWidth, height: mainHeight)
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {
                    self.addPhoneView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
                UIView.animate(withDuration: 0.5) {
                    self.addPhoneView.backgroundColor = UIColor.white
                }
        
            }
            if (count == 1)
            {
                self.phoneOneView.isHidden = false
                self.phoneOneTextField.becomeFirstResponder()

            }
            if (count == 2)
            {
                self.phoneTwoView.isHidden = false
                 self.phoneTwoTextField.becomeFirstResponder()
            }
            if (count == 3)
            {
                self.phoneThreeView.isHidden = false
                 self.phoneThreeTextField.becomeFirstResponder()
            }
        }
    }
    func phoneNumOne()
    {
        UIView.animate(withDuration: 0.4) {
            
            if (self.delButtonPhoneOne.isHidden)
            {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.delButtonPhoneOne.layer.add(transition, forKey: kCATransition)
                
                self.delButtonPhoneOne.isHidden = false
                self.horViewPhoneOne.transform = self.horViewPhoneOne.transform.rotated(by: .pi/2)
            }
            else
            {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.delButtonPhoneOne.layer.add(transition, forKey: kCATransition)
                self.delButtonPhoneOne.isHidden = true
                self.horViewPhoneOne.transform = self.horViewPhoneOne.transform.rotated(by: .pi/2)
            }
        }
    }
    func phoneNumTwo()
    {
        UIView.animate(withDuration: 0.4) {
            
            if (self.delButtonPhoneTwo.isHidden)
            {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.delButtonPhoneTwo.layer.add(transition, forKey: kCATransition)
                
                self.delButtonPhoneTwo.isHidden = false
                self.horViewPhoneTwo.transform = self.horViewPhoneTwo.transform.rotated(by: .pi/2)
            }
            else
            {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.delButtonPhoneTwo.layer.add(transition, forKey: kCATransition)
                self.delButtonPhoneTwo.isHidden = true
                self.horViewPhoneTwo.transform = self.horViewPhoneTwo.transform.rotated(by: .pi/2)
            }
        }
    }
    func phoneNumThree()
    {
        UIView.animate(withDuration: 0.4) {
            
            if (self.delButtonPhoneThree.isHidden)
            {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.delButtonPhoneThree.layer.add(transition, forKey: kCATransition)
                
                self.delButtonPhoneThree.isHidden = false
                self.horViewPhoneThree.transform = self.horViewPhoneThree.transform.rotated(by: .pi/2)
            }
            else
            {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.delButtonPhoneThree.layer.add(transition, forKey: kCATransition)
                self.delButtonPhoneThree.isHidden = true
                self.horViewPhoneThree.transform = self.horViewPhoneThree.transform.rotated(by: .pi/2)
            }
        }
    }
    
    @IBAction func deletePhoneOneAction(_ sender: Any) {
        count = count - 1
        determineActiveViews()
       
    }
  
    @IBAction func deletePhoneTwoAction(_ sender: Any) {
        count = count - 1
        determineActiveViews()
      
    }
    
    @IBAction func deletePhoneThreeAction(_ sender: Any) {
        count = count - 1
        determineActiveViews()
    }
    
    
    func determineActiveViews()
    {
        if (count == 0)
        {
            let mainWidth = addPhoneView.frame.width
            let xcoor = addPhoneView.frame.minX
            let ycoor = addPhoneView.frame.minY
            let mainHeight = addPhoneView.frame.height
            addPhoneView.frame = CGRect(x: xcoor, y: ycoor - 50, width: mainWidth, height: mainHeight)
            self.phoneOneView.isHidden = true
            
            if (!self.delButtonPhoneOne.isHidden)
            {
                if (self.horViewPhoneOne.bounds.width == 15.0)
                {
                    self.horViewPhoneOne.transform = self.horViewPhoneOne.transform.rotated(by: .pi/2)
                }
                self.delButtonPhoneOne.isHidden = true
            }
            self.phoneOneTextField.text = ""
            self.doneBarButton.isEnabled = false
        }
        if (count == 1)
        {
            let mainWidth = addPhoneView.frame.width
            let xcoor = addPhoneView.frame.minX
            let ycoor = addPhoneView.frame.minY
            let mainHeight = addPhoneView.frame.height
            addPhoneView.frame = CGRect(x: xcoor, y: ycoor - 50, width: mainWidth, height: mainHeight)
            self.phoneTwoView.isHidden = true
            self.phoneOneTextField.becomeFirstResponder()
            if (!self.delButtonPhoneTwo.isHidden)
            {
                if (self.horViewPhoneTwo.bounds.width == 15.0)
                {
                    self.horViewPhoneTwo.transform = self.horViewPhoneTwo.transform.rotated(by: .pi/2)
                }
                self.delButtonPhoneTwo.isHidden = true
            }
            self.phoneTwoTextField.text = ""
            
        }
        if (count == 2)
        {
            let mainWidth = addPhoneView.frame.width
            let xcoor = addPhoneView.frame.minX
            let ycoor = addPhoneView.frame.minY
            let mainHeight = addPhoneView.frame.height
            addPhoneView.frame = CGRect(x: xcoor, y: ycoor - 50, width: mainWidth, height: mainHeight)
            self.phoneThreeView.isHidden = true
            self.phoneTwoTextField.becomeFirstResponder()
            if (!self.delButtonPhoneThree.isHidden)
            {

                if (self.horViewPhoneThree.bounds.width == 15.0)
                {
                    self.horViewPhoneThree.transform = self.horViewPhoneThree.transform.rotated(by: .pi/2)
                }
                self.delButtonPhoneThree.isHidden = true
                
            }
            self.phoneThreeTextField.text = ""

        }
       
    }
    /////////// Determining Done button state //////
    @IBAction func firstNameEditing(_ sender: Any) {
        if !(firstNameTextField.text?.isEmpty)!
        {
            if (!self.doneButton.isEnabled)
            {
                self.doneButton.isEnabled = false
            }
        }
        if ((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)! && (phoneOneTextField.text?.isEmpty)! && (phoneTwoTextField.text?.isEmpty)! && (phoneThreeTextField.text?.isEmpty)!)
        {
            self.doneButton.isEnabled = false
        }
    }
    @IBAction func lastNameEdiiting(_ sender: Any) {
        if !(lastNameTextField.text?.isEmpty)!
        {
            if (!self.doneButton.isEnabled)
            {
                self.doneButton.isEnabled = false
            }
        }
        if ((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)! && (phoneOneTextField.text?.isEmpty)! && (phoneTwoTextField.text?.isEmpty)! && (phoneThreeTextField.text?.isEmpty)!)
        {
            self.doneButton.isEnabled = false
        }
    }
    @IBAction func phoneOneEditing(_ sender: Any) {
        if !(phoneOneTextField.text?.isEmpty)!
        {
            if (!self.doneButton.isEnabled)
            {
                self.doneButton.isEnabled = true
            }
            self.doneBarButton.isEnabled = true
        }
        if (phoneOneTextField.text?.isEmpty)!
        {
             self.doneBarButton.isEnabled = false
             self.doneButton.isEnabled = false
        }
        if ((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)! && (phoneOneTextField.text?.isEmpty)! && (phoneTwoTextField.text?.isEmpty)! && (phoneThreeTextField.text?.isEmpty)!)
        {
            self.doneButton.isEnabled = false
           
        }
    }
    @IBAction func phoneTwoEditing(_ sender: Any) {
        if !(phoneTwoTextField.text?.isEmpty)!
        {
            if (!self.doneButton.isEnabled)
            {
                self.doneButton.isEnabled = true
            }
            self.doneBarButton.isEnabled = true
        }
        if ((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)! && (phoneOneTextField.text?.isEmpty)! && (phoneTwoTextField.text?.isEmpty)! && (phoneThreeTextField.text?.isEmpty)!)
        {
            self.doneButton.isEnabled = false
        }
        if (phoneTwoTextField.text?.isEmpty)!
        {
            self.doneBarButton.isEnabled = false
            self.doneButton.isEnabled = false
        }
    }
    @IBAction func phoneThreeEditing(_ sender: Any) {
        if !(phoneThreeTextField.text?.isEmpty)!
        {
            if (!self.doneButton.isEnabled)
            {
                self.doneButton.isEnabled = true
            }
            self.doneBarButton.isEnabled = true
        }
        if ((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)! && (phoneOneTextField.text?.isEmpty)! && (phoneTwoTextField.text?.isEmpty)! && (phoneThreeTextField.text?.isEmpty)!)
        {
            self.doneButton.isEnabled = false
        }
        if (phoneThreeTextField.text?.isEmpty)!
        {
            self.doneBarButton.isEnabled = false
            self.doneButton.isEnabled = false
        }
    }
    //////////////////////////////////////////////////////
    @objc func doneClicked()
    {
        if (phoneOneTextField.isFirstResponder)
        {
            
            phoneOneTextField.resignFirstResponder()
            doneBarButton.isEnabled = false

  
        }
        if (phoneTwoTextField.isFirstResponder)
        {
            phoneTwoTextField.resignFirstResponder()
            doneBarButton.isEnabled = false
        }
        if (phoneThreeTextField.isFirstResponder)
        {
            phoneThreeTextField.resignFirstResponder()
            doneBarButton.isEnabled = false
        }
    }
    @objc func cancelClicked()
    {
        if (phoneOneTextField.isFirstResponder)
        {
            phoneOneTextField.text = ""
            phoneOneTextField.resignFirstResponder()
            doneBarButton.isEnabled = false

        }
        if (phoneTwoTextField.isFirstResponder)
        {
            phoneTwoTextField.text = ""
            phoneTwoTextField.resignFirstResponder()
            doneBarButton.isEnabled = false

            
        }
        if (phoneThreeTextField.isFirstResponder)
        {
            phoneThreeTextField.text = ""
            phoneThreeTextField.resignFirstResponder()
            doneBarButton.isEnabled = false

        }
    }
    /////////////////////////////////////////////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(firstNameTextField.isFirstResponder)
        {
            if !(firstNameTextField.text?.isEmpty)!
            {
                firstNameTextField.resignFirstResponder()
            }
        }
        if (lastNameTextField.isFirstResponder)
        {
            if !(firstNameTextField.text?.isEmpty)!
            {
                lastNameTextField.resignFirstResponder()
            }
        }
        return true
    }
    ////////////////////////////////////////////////////////
    
    @objc func cancelTextBarClicked()
    {
       if (firstNameTextField.isFirstResponder)
       {
        firstNameTextField.resignFirstResponder()
        firstNameTextField.text = ""
       }
        if (lastNameTextField.isFirstResponder)
        {
            lastNameTextField.resignFirstResponder()
            lastNameTextField.text = ""
        }
        if ((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)!)
        {
            self.doneButton.isEnabled = false
        }
    }
    @objc func doneButtonPressed()
    {
        
        self.delegate = contactsViewController()
        delegate?.newContactIsAdded!(firstName: self.firstNameTextField.text, LastName: self.lastNameTextField.text, phoneOne: self.phoneOneTextField.text, phoneTwo: self.phoneTwoTextField.text, phoneThree: self.phoneThreeTextField.text)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainValu")  as! mainTabViewController
        self.present(newViewController, animated: true, completion: nil)
        
    }
    ///////////////////////////////////
    
}
