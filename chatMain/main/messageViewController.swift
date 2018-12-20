//
//  messageViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 9/17/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class messageViewController: connectionStatus, mainProtocol {

    var profilePic = UIView()
    var statusDot = UIView()
    var nameLabel = UILabel()
    var chatStatusLabel = UILabel()
    var intialsLabel = UILabel()
    var messageCountLabel = UILabel()
    let labelsDimension = 20*sqrt(2)
    let xlabelDimension = (40 - 20*sqrt(2))/2
    let ylabelDimension = (40 - 20*sqrt(2))/2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBar()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.popViewController(animated: true)
         self.profilePic.isHidden = true
         self.statusDot.isHidden = true
         self.messageCountLabel.isHidden = true
         self.nameLabel.isHidden = true
         self.chatStatusLabel.isHidden = true
         self.tabBarController?.tabBar.isHidden = false

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    //* Creating a custom nav bar ////
    func createNavBar()
    {
        self.tabBarController?.tabBar.isHidden = true
        profilePic.frame = CGRect(x: mainScreenWidth/2 - 20, y: 0, width: 40, height: 40)
        profilePic.layer.cornerRadius = 20
        profilePic.clipsToBounds = true
        profilePic.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.5)
        self.navigationController?.navigationBar.addSubview(profilePic)
        
        statusDot.frame = CGRect(x: mainScreenWidth-15, y: 10, width: 10, height: 10)
        statusDot.backgroundColor = UIColor.red
        statusDot.layer.cornerRadius = 5
        statusDot.clipsToBounds = true
        self.navigationController?.navigationBar.addSubview(statusDot)
        
        messageCountLabel.frame = CGRect(x: 30, y: 15, width: 15, height: 15)
        messageCountLabel.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        messageCountLabel.text = "3"
        self.navigationController?.navigationBar.addSubview(messageCountLabel)
        
        ///// Name Label //////
        
        nameLabel.frame = CGRect(x: 0 , y: 21, width: mainScreenWidth, height: 23)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        if let name = UserDefaults.standard.string(forKey: "nameTemp")
        {
            nameLabel.text = name
        }
        nameLabel.textAlignment = .right
        self.navigationController?.navigationBar.addSubview(nameLabel)
        
        chatStatusLabel.frame = CGRect(x: mainScreenWidth - 45, y: 10, width: 40, height: 10)
        chatStatusLabel.font = UIFont.italicSystemFont(ofSize: 8)
        chatStatusLabel.text = ""
        self.navigationController?.navigationBar.addSubview(chatStatusLabel)
        
        
        intialsLabel.frame = CGRect(x: xlabelDimension, y: ylabelDimension, width: labelsDimension, height: labelsDimension)
        if let intials = UserDefaults.standard.string(forKey: "intialsTemp")
        {
            intialsLabel.text = intials
            intialsLabel.textAlignment = .center
        }
        self.profilePic.addSubview(intialsLabel)
       
        
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "lastTemp")



    }
    func userName(intials:String, name:String) {
        UserDefaults.standard.set(name, forKey: "nameTemp")
        UserDefaults.standard.set(intials, forKey: "intialsTemp")
        
    }
}
