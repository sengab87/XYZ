//
//  signUpViewController.swift
//  xmppTut
//
//  Created by Ahmed Sengab on 7/24/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class signUpViewController: phoneNumberViewController {

    /////////// Here is the properties of the view the signupbutton
    /// the countyview, the disclosure button
    //// country name label is name
    /// number text field is number
    /// codeTextfield is country code
    ////////////////////////////////////////////////////////////////
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var disclosureLabel: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        intializeView()
        createToolBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        determineCountryCode()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
    func intializeView()
    {
        ///// we call mainLabelView from super class then
        /// we override the mainlabel text
        //// here we state main label and disclosure button
        
        self.mainLabel.text = "Enter Phone Number"
        mainLabelView()
        let arrow = UITableViewCell()
        arrow.frame = disclosureLabel.bounds
        arrow.accessoryType = .disclosureIndicator
        arrow.isUserInteractionEnabled = false
        disclosureLabel.addSubview(arrow)
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ////// If we touch the country view we go to country ////////
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            if hitView === countryView
            {
                self.performSegue(withIdentifier: "country", sender: self)
            }
            else
            //// else we have to hide keyboard
            {
                hideKeyboard()
            }
        }
    }
    func determineCountryCode(){
        /// This Function Determine the Country Code
        let countryCode = UserDefaults.standard.object(forKey: "countryCode")
        let country = UserDefaults.standard.object(forKey: "countryName")
        if (countryCode == nil && country == nil)
        {
            
            countryName.text = "United States"
            codeTextField.text = "1"
        }
        else
        {
            countryName.text = country as? String
            codeTextField.text = countryCode as? String
        }
    }
    
    func determineCountryBasedOnCode()
    {
        //// Here we determine Country by code
        let countInCodeField = codeTextField.text?.count
        if (countInCodeField != nil)
        {
            if (countInCodeField! < 4)
            {
                outerLoop: for index in 0...countryNames.count-1
                {
                    if(codeTextField.text! == "1")
                    {
                        countryName.text? = "United States"
                        break outerLoop
                    }
                    innerLoop: if ("+"+codeTextField.text!) == codes[index]
                    {
                        countryName.text? = countryNames[index]
                        break outerLoop
                    }
                    else
                    {
                        countryName.text? = "Invalid Country Code"
                    }
                }
            }
            else
            {
                countryName.text? = "Invalid Country Code"
            }
        }
    }
    @IBAction func codeTextFieldDidChange(_ sender: UITextField) {
        //// Here we check if code is changed and based on it we get country
        if (sender.text?.isEmpty)!
        {
            countryName.text = "Select from list"
        }
        else
        {
            determineCountryBasedOnCode()
        }
    }
    
    
    @IBAction func phoneNumberChanged(_ sender: UITextField) {
        if (sender.text?.isEmpty)!
        {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
            
        }
        else
        {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1
        }
    }
    
    func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    func createToolBar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        doneButton.tintColor = UIColor(red: red, green:  green, blue: blue, alpha: 1)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.cancelClicked))
        cancelButton.tintColor = UIColor(red: red, green:  green, blue: blue, alpha: 1)
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, flexButton, doneButton], animated: false)
        codeTextField.inputAccessoryView = toolBar
        numberTextField.inputAccessoryView = toolBar
    }
    @objc func doneClicked()
    {
        self.view.endEditing(true)
    }
    @objc func cancelClicked()
    {
        if (numberTextField.isEditing)
        {
            self.numberTextField.text = ""
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
            self.view.endEditing(true)
        }
        if (codeTextField.isEditing)
        {
            
            self.view.endEditing(true)
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.signUpButton.isEnabled = false
        self.signUpButton.alpha = 0.5;
        /// if signup button is pressed we call the backend
        passVariables()
    }
    func passVariables()
    {
        let url = URL(string:"https://verify.estore87.com/logIn/authentication.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body = "code=\(codeTextField.text!)&number=\(numberTextField.text!)"
        print(body)
        request.httpBody=body.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if (error == nil)
            {
                print(response)
                DispatchQueue.main.async(execute: {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Dictionary<AnyHashable,AnyObject>
                        //print(json)
                        guard let parseJson = json else{
                            return
                        }
                        //print(parseJson)
                        let status = parseJson["status"] as? String
                        if (status != nil)
                        {
                            if (status == "200")
                            {
                                self.label.text  = "Our services are currently unavailable"
                                self.showView()
                                self.signUpButton.isEnabled = true
                                self.signUpButton.alpha = 1;
                            }
                            if (status == "300")
                            {
                                if (self.numberTextField.text != nil)
                                {
                                    let token = parseJson["token"]
                                    //// test ////
                                    print(token)
                                    /////////////
                                    UserDefaults.standard.set(self.codeTextField.text, forKey: "code")
                                    UserDefaults.standard.set(self.numberTextField.text, forKey: "number")
                                    UserDefaults.standard.set(self.codeTextField.text! + self.numberTextField.text!, forKey: "username")
                                    UserDefaults.standard.set(token, forKey:"token")
                                    self.generateRandomPass()
                                    
                                }
                            }
                        }
                    }
                    catch
                    {
                        print(error)
                        self.signUpButton.isEnabled = true
                        self.signUpButton.alpha = 1;
                        self.label.text   = "Please Check Phone Number"
                        self.showView()
                    }
                })
            }
            }.resume()
    }
}
