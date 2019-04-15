//
//  ViewController.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/24/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
@IBDesignable
class GoalsVC: UIViewController {

    var goals : [Goal] = []
    @IBOutlet weak var goalsTableView : UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func addGoalBtnWasPressed(_ sender : Any)
    {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") as? CreateGoalVC else { return }
        presentDetail(createGoalVC)
       
    }
   
    
}

