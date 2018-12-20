//
//  ViewController.swift
//  KVO_example
//
//  Created by Ahmed Sengab on 12/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class User : NSObject
{
    @objc dynamic var  name = String()
    @objc dynamic var age = 0
}
class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @objc let user = User()
    var nameObsToken : NSKeyValueObservation?
    var ageObsToken : NSKeyValueObservation?
    var inputTextObsToken : NSKeyValueObservation?
    @objc dynamic var inputText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // new after change
        // intial intial one
        // old one before change
        // prior before and after change
       nameObsToken = observe(\ViewController.user.name, options: [.new], changeHandler:  { (vc, change) in
            guard let updatedName = change.newValue else {
                return
            }
            vc.nameLabel.text = updatedName
        })
        ageObsToken = observe(\.user.age, options: [.new], changeHandler:  { (vc, change) in
            guard let updatedage = change.newValue else {
                return
            }
            vc.ageLabel.text = String(updatedage)
        })
        inputTextObsToken =  observe(\.inputText, options: [.new], changeHandler:  { (vc, change) in
            guard let updatedInputText = change.newValue as? String else {return}
            vc.textLabel.text = updatedInputText
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nameObsToken?.invalidate()
        ageObsToken?.invalidate()
    }
    @IBAction func didUpdateName(_ sender: Any) {
    user.name = "kilo"
    }
    
    @IBAction func didUpdateAge(_ sender: Any) {
        user.age = 25
    }
    @IBAction func textFieldDidChange(_ sender: Any) {
        inputText = textField.text
    }
}

