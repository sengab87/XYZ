//
//  settingsViewController.swift
//  chatMain
//
//  Created by Ahmed Sengab on 9/18/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class settingsViewController: connectionStatus {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profilePicView: UIView!
    @IBOutlet weak var intialsLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var disclosureIndication: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    var imageTest = UIImageView()
    let disclosure = UITableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewInit()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let object = UserDefaults.standard.object(forKey: "profileImage") as? Data
        
        if (object != nil)
        {
            imageTest.image = UIImage(data: object!)
            let final = imageTest.image!.jpegData(compressionQuality: 1)
            print((final?.count)! / 1024)
            
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.isNavigationBarHidden = false
            imageTest.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            imageTest.layer.cornerRadius = 40
            imageTest.clipsToBounds = true
            imageTest.image = UIImage(data: final!)
            //imageTest.contentMode = .scaleAspectFit
            profilePicView.addSubview(imageTest)
        }
        
    }
    func profileViewInit()
    {
        
       disclosure.frame = disclosureIndication.bounds
       disclosure.accessoryType = .disclosureIndicator
        //disclosure.isUserInteractionEnabled = false
        disclosureIndication.addSubview(disclosure)
        
        self.intialsLabel.text = ""
        self.profilePicView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.5)
        
        self.numberLabel.text = "+" + UserDefaults.standard.string(forKey: "username")!
        
        self.fullNameLabel.text = "Add Profile Picture"
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ////// If we touch the country view we go to country ////////
        
            
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            if (hitView === self.profileView)
            {
                self.performSegue(withIdentifier: "profile", sender: self)
            }
        }
    }

}
