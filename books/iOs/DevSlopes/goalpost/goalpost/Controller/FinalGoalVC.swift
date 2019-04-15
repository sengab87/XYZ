//
//  FinalGoalVC.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/25/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FinalGoalVC: UIViewController {

    // IBOutlets
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTxtField: UITextField!
    
    var goalDescription : String!
    var goalType : GoalType!
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()

        // Do any additional setup after loading the view.
    }

    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        if pointsTxtField.text != ""{
            self.save { (Success) in
                dismiss(animated: true, completion: nil)
            }
        }
    }
    func initData(description : String, type : GoalType)
    {
        self.goalDescription = description
        self.goalType = type
    }
    
    @IBAction func backBtnPressed(_ sender:Any)
    {
        self.dismissDetail()
    }
    func save(completion: (_ finished: Bool) -> ())
    {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: manageContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTxtField.text!)!
        goal.goalProgress = Int32(0)
        do {
            try manageContext.save()
            completion(true)
        }
        catch{
            debugPrint("couldnot save \(error.localizedDescription)")
            completion(false)
        }
        
    }
}
