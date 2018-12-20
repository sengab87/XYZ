//
//  connectionStatus.swift
//  chatMain
//
//  Created by Ahmed Sengab on 8/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//


struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}

import UIKit

class connectionStatus: ViewController {

    ///////////////// init ////////////
    let statusLabel = UILabel()
    var reachability = Reachability()
    var mainScreenWidth:CGFloat = UIScreen.main.bounds.width
    var mainScreenHeight:CGFloat = UIScreen.main.bounds.height
    let red:CGFloat = 67.4512825906277/255.0
    let green:CGFloat = 215.241137444973/255.0
    let blue:CGFloat = 108.674077391624/255.0
    let statusView = UIView()
    let width = UIScreen.main.bounds.width
    /////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
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
        
        // Dispose of any resources that can be recreated.
    }
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if (reachability.connection != .none) {
            hideStatus()
            if !(XMPPTest.shared.stream.isConnected)
            {
                XMPPTest.shared.connect()
            }
            
        }
        else
        {
        
          showStatus()
        }
    }
    func createView()
    {
        self.view.addSubview(statusView)
        statusView.frame = CGRect(x: 0, y: 0, width: width, height: 60)
        statusView.addSubview(statusLabel)
        statusLabel.frame = CGRect(x: 0, y: 20, width: width, height: 30)
        statusLabel.textAlignment = NSTextAlignment.center
        //statusView.backgroundColor = UIColor.gray
        statusLabel.text = "Please Check Internet Connection"
        statusLabel.textColor = UIColor.red
        
    }
    func showStatus()
    {
       statusView.isHidden = false
       statusLabel.text = ""
        
        //self.title = "Check Internet Connection"
        
    }
    func hideStatus()
    {
        statusView.isHidden = true
    }
}
