//
//  CreateGoalVC.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/25/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var goalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any)
    {
        if goalTextView.text != "" && goalTextView.text != "What is your Goal?"{
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinalGoalVC") as? FinalGoalVC else { return }
            finishGoalVC.initData(description: goalTextView.text, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
            
        }
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermButton.setDeselectedColor()
        longTermButton.setSelectedColor()
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
       // dismissDetail(<#T##viewControllerToPresent: UIViewController##UIViewController#>)
        dismissDetail()
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.goalTextView.text = ""
        textView.textColor = UIColor.black
        return true
    }
    
}
