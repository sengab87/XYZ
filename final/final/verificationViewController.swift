//
//  verificationViewController.swift
//  final
//
//  Created by Dina Maala on 5/26/18.
//  Copyright © 2018 Dina Maala. All rights reserved.
//

///////////// need to give access /////
//// dim buttone or resend code /////
/// show activity indicator ///////
/// dismiss keyboard /////
/// if code correct give access otherwise show that code expiredd ///
//////
import UIKit

class verificationViewController: UIViewController,UITextFieldDelegate {

    //////////////////////////Properties and global Variable ////////////////////
    ////// Okbutton is button to press when token is wrong to dismiss view //////
    //// seperatingline is line the seperatres ok from label ////////////////////
    /// activtiy indicator is indicator if token is correct /////////////////////
    /// mainStatusViewBar is the view that has ok and label /////////////////////
    // mainStatusViewLabel is the label that will be called if connected or not//
    // greyview is background ///////////////////////////////////////////////////
    // codeText field is field where we have code to be enetered ////////////////
    // TimerLabel is the number of seconds remaining for code to expire /////////
    
    @IBOutlet weak var resendCode: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var seperatingLine: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mainViewStatusLabel: UILabel!
    @IBOutlet weak var mainStatusViewBar: UIView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    var timerInterval = 120
    var timer = Timer()
    var timeIntervalToken = 1
    var timerToken = Timer()
    ////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////////////////////// Intialization of Timer ///////////////////////
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        //////////////////////////////////////////////////////////////////////
    
        ///////// Dispatch to delete the token //////////////////////////////////////////////
        
        DispatchQueue.global(qos: .userInitiated).async(execute: {
            do
            {
                
                let currentToken = UserDefaults.standard.object(forKey: "token") as? Int
              
                if (currentToken != nil)
                {
                    if (currentToken != 0)
                    {
                        sleep(119);
                        let refreshedToken = UserDefaults.standard.object(forKey: "token") as? Int
                        if(refreshedToken != nil)
                        {
                            if (refreshedToken != 1)
                            {
                                UserDefaults.standard.set(0, forKey: "token")
                            }
                        }
                        
                    }
                }
            }
            
        })
        ///////////////////////////////////////////////////////////////////////////////////////
    }
    override func viewWillAppear(_ animated: Bool) {
        initialView()
         self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////////// Timer function ///////////////////////////////////////
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
            self.resendCode.isHidden = false
            self.navigationItem.hidesBackButton = false
            self.resendCode.isEnabled = true
            
        }
    }
    ////////////////////////////////////////////////////////////////////////////////
    @IBAction func textFieldEditing(_ sender: UITextField) {
        if (codeTextField.text != nil)
        {
            if !((codeTextField.text?.isEmpty)!)
            {
                if(codeTextField.text?.count==6)
                {
                    let intText = Int(codeTextField.text!)
                    let token = UserDefaults.standard.object(forKey: "token") as? Int
                    if (intText == token)
                    {
                        greyView.isHidden = false
                        greyView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                        mainStatusViewBar.isHidden = false
                        mainStatusViewBar.layer.cornerRadius = 10
                        mainStatusViewBar.backgroundColor = UIColor.white
                        mainViewStatusLabel.text = "Connecting"
                        activityIndicator.isHidden = false
                        seperatingLine.isHidden = true
                        okButton.isHidden = true
                        timerToken = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(delayView), userInfo: nil, repeats: true)
                    }
                    else
                    {
                        greyView.isHidden = false
                        greyView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                        mainStatusViewBar.isHidden = false
                        mainStatusViewBar.layer.cornerRadius = 10
                        mainStatusViewBar.backgroundColor = UIColor.white
                        mainViewStatusLabel.text = "You have entered an invalid code. Please try again"
                        self.activityIndicator.isHidden = true
                    }
                }
            }
            
        }
        
    }
    
    ///////////// Ok Buttone Pressed to hide View ////////////////////////////////////
  
    @IBAction func okButtonePressed(_ sender: UIButton) {
        initialView()
    }
    @objc func delayView()
    {
     timerToken.invalidate()
     UserDefaults.standard.set(1, forKey: "token")
     self.performSegue(withIdentifier: "registrationEmailSegue", sender: self)
    }
    /////////////////////////////////////////////////////////////////////////////////
    @IBAction func resendCode(_ sender: UIButton) {
        
        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        //////////////////////////////////////////////////////////////////////
        
        ///////// Dispatch to delete the token //////////////////////////////////////////////
        /*DispatchQueue.global(qos: .userInitiated).async(execute: {
            do
            {
                
                let currentToken = UserDefaults.standard.object(forKey: "token") as? Int
                
                if (currentToken != nil)
                {
                    if (currentToken != 0)
                    {
                        sleep(119);
                        let refreshedToken = UserDefaults.standard.object(forKey: "token") as? Int
                        if(refreshedToken != nil)
                        {
                            if (refreshedToken != 1)
                            {
                                UserDefaults.standard.set(0, forKey: "token")
                            }
                        }
                        
                    }
                }
                
                
            }
            
        })*/
        
    }
    /////// Intial View That Will appear view will appear ////////////////////////////
    func initialView()
    {
        
        self.navigationItem.hidesBackButton = true
        self.resendCode.isHidden =  true
        greyView.isHidden = true
        mainStatusViewBar.isHidden = true
        let phoneNumberLocal = UserDefaults.standard.object(forKey: "phoneNumber") as! String
        let codeLocal =  UserDefaults.standard.object(forKey: "countryCode") as! String
        self.phoneNumberLabel.text = "+" + codeLocal + phoneNumberLocal
    }
    ///////////////////////////////////////////////////////////////////////////////////
}
