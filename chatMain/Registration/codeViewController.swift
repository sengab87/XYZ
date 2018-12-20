//
//  codeViewController.swift
//  xmppTut
//
//  Created by Ahmed Sengab on 8/7/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class codeViewController: phoneNumberViewController, UITextFieldDelegate,mainProtocol {

    
    var token = UserDefaults.standard.object(forKey: "token") as! Int
    
    var timerInterval = 30
    var timer = Timer()
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    var duplicateCodeField = UITextField()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        XMPPTest.shared.regDelegate = self
        XMPPTest.shared.authDelegate = self
        setTimer()
        mainLabelView()
        phoneNumberLabel()
        intialMaskView()
    }
    /////// This function shows the intial phone number and mainLabel ///////
    func phoneNumberLabel()
    {
        let currentPhoneNumber = UserDefaults.standard.object(forKey: "username") as? String
        if (currentPhoneNumber != nil)
        {
            self.mainLabel.text = "+" + currentPhoneNumber!
            print(self.mainLabel.text!)
            self.infoLabel.text = "Please Enter Verification Code"
        }
        self.navigationItem.hidesBackButton = true
    }
    /////////////////////////////////////////////////////////////////////////
    /////////////// Hide resend code button ////////
    func intialMaskView()
    {
        
        self.authButton.isHidden = true
        self.authButton.backgroundColor?.withAlphaComponent(0.5)
        print(1)
    }
    /////////////////////////////////////////////////
    func setTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    /////////////////////// update timer //////////////////////////////////////////
    @objc func updateTimerLabel()
    {
        timerInterval = timerInterval - 1
        if timerInterval > 60
        {
            self.timerLabel.text! = "Your code will expire in" + " 1:" + String(timerInterval-60)
            if (timerInterval<70)
            {
                self.timerLabel.text! = "Your code will expire in" + " 1:0" + String(timerInterval-60)
            }
        }
        else if (timerInterval == 60)
        {
            self.timerLabel.text! = "Your code will expire in" + " 1:" + "00"
        }
        else if (timerInterval > 0)
        {
            self.timerLabel.text! = "Your code will expire in" + " 0:" +
                String(timerInterval)
            if (timerInterval<10)
            {
                self.timerLabel.text! = "Your code will expire in" + " 0:0" + String(timerInterval)
            }
        }
        else
        {
            self.timerLabel.text! = "Your code already expired 0:00"
            timer.invalidate()
            navigationItem.hidesBackButton = false
            navigationController?.navigationBar.tintColor = UIColor.init(red: red, green:  green, blue: blue, alpha: 1)
            self.authButton.isEnabled = true
            self.authButton.isHidden = false
            token = 0
        }
    }
    
    @IBAction func codeField(_ sender: UITextField) {
        duplicateCodeField = sender
        if let code = sender.text
        {
            if(sender.text?.count == 6)
            {
                if (Int(code) == token)
                {
                   
                    timer.invalidate()
                    XMPPTest.shared.registerUser()
                }
                else
                {
                    sender.text = ""
                    sender.isUserInteractionEnabled = false
                    self.label.text = "You have entered a wrong authorization code. Please try again"
                    showView()
                    
                    
                }
            }
            if ((sender.text?.count)! > 6)
            {
                sender.text = ""
                sender.isUserInteractionEnabled = false
                self.label.text = "You have entered a wrong authorization code. Please try again"
                showView()
                
            }
        }
    }
    @objc override func hideViewButton(sender: UIButton!)
    {
        duplicateCodeField.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        self.header.isHidden = true
        self.mask.isHidden = true
    }
    
    
    @IBAction func resendButton(_ sender: UIButton) {
            generateNewCode()
            timerInterval = 30
            setTimer()
    }
    func generateNewCode()
    {
        self.authButton.isHidden = true
        self.navigationItem.hidesBackButton = true
        let code = UserDefaults.standard.object(forKey: "countryCode")
        let number = UserDefaults.standard.object(forKey: "number")
        if (code != nil && number != nil)
        {
            
        let url = URL(string:"https://verify.estore87.com/logIn/authentication.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body = "code=\(code!)&number=\(number!)"
            print(body)
        request.httpBody=body.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if (error == nil)
            {
                
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
                            if (status != "200")
                            {
                                self.token = parseJson["token"] as! Int
                                UserDefaults.standard.set(self.token, forKey: "token")
                                //// test ////
                                print(UserDefaults.standard.object(forKey: "token"))
                                /////////////
                                self.generateNewCode()
                            }
                            else
                            {
                                self.label.text  = "Our services are currently unavailable"
                                self.showView()
                            }
                        }
                    }
                    catch
                    {
                        self.label.text   = "Please Check Phone Number"
                        self.showView()
                    }
                })
            }
            }.resume()
    }
    }
    func userRegisterStatus(value: Bool) {
        if (value == true)
        {
            print("delegate")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainValu")  as! mainTabViewController
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    func authenticationStatus(value: Bool) {
        
    }
    /////////////////////////////////////////////////////////////////////////
}
