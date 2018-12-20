//
//  mainClass.swift
//  xmppTut
//
//  Created by Ahmed Sengab on 8/5/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class mainClass: UIViewController {

    /////// View and label to indicate connection status ////
    let header = UIView()
    let mask = UIView()
    var button = UIButton(type: .system)
    var label = UILabel()
    var reachability = Reachability()
    var mainScreenWidth:CGFloat = 0
    var mainScreenHeight:CGFloat = 0
    let red:CGFloat = 67.4512825906277/255.0
    let green:CGFloat = 215.241137444973/255.0
    let blue:CGFloat = 108.674077391624/255.0
    /////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createscreenSize()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do
        {
            try reachability?.startNotifier()
        }catch
        {
            
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    //////////////////////// intialize the view //////////////////////////
    func createscreenSize()
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        mainScreenWidth = screenWidth
        mainScreenHeight = screenHeight
        
        
        //header.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20)
        //header.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        //self.label.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20)
    }
    
    ////////////////////////////////////////////////////////////////////////
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if (reachability.connection != .none) {
            hideView()
        }
        else
        {
            self.label.text = "Check Internet Connection"
            showView()
        }
    }
    func showView()
    {
        let halfScreenWidth =  mainScreenWidth/2
        let halfScreenHeight = mainScreenHeight/3
        header.frame = CGRect(x: halfScreenWidth-100, y: halfScreenHeight-80, width: 200, height: 160)
        button.frame = CGRect(x: 0, y: 120, width: 200, height: 40)
        mask.frame =  CGRect(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight)
        label.frame = CGRect(x: 0, y: 30, width: 200, height: 90)
        label.textAlignment = .center
        label.numberOfLines = 5
        mask.backgroundColor = UIColor.white.withAlphaComponent(0)
        header.backgroundColor = UIColor.darkGray
        view.addSubview(mask)
        mask.addSubview(header)
        header.addSubview(label)
        mask.isMultipleTouchEnabled = false
        mask.isHidden = false
        header.isHidden = false
        header.layer.cornerRadius = 10
        header.clipsToBounds = true
        button.isHidden = true
        
        if (label.text != "Check Internet Connection")
        {
            header.addSubview(button)
            button.isHidden = false
            button.setTitle("OK", for: .normal)
            button.setTitleColor(UIColor.init(red: self.red, green: self.green, blue: self.blue, alpha: 1), for: .normal)
            button.isEnabled = true
            okPressed()
        }
    }
    func hideView()
    {
        view.isMultipleTouchEnabled = true
        header.isHidden = true
        mask.isHidden = true
        
    }
    func okPressed()
    {
        button.addTarget(self, action: #selector(hideViewButton), for: .touchDown)
        
    }
    @objc func hideViewButton(sender: UIButton!)
    {
        
        view.isMultipleTouchEnabled = true
        self.header.isHidden = true
        self.mask.isHidden = true
    }
   
   
}
