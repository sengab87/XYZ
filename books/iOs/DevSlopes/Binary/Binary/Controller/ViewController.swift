//
//  ViewController.swift
//  Binary
//
//  Created by Ahmed Sengab on 1/21/19.
//  Copyright © 2019 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var valueEntrytxtField: UITextField!
    @IBOutlet weak var binaryBtn: UIButton!
    
    @IBOutlet weak var decimalBtn: UIButton!
    let placeholder = NSAttributedString(string: "Enter a binary or a decimal value", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont(name: "Avenir next", size: 24)! ])
    override func viewDidLoad() {
        super.viewDidLoad()
        disableBtn()
        let binDigit = BinaryDecimal(145)
        print(binDigit.calculateBinaryValueForInt())
        self.valueEntrytxtField.attributedPlaceholder = placeholder
        self.valueEntrytxtField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func textDidChange(){
        self.valueEntrytxtField.placeholder = ""
        if ((self.valueEntrytxtField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!)
        {
            disableBtn()
        }else {
            enableBtn()
        }
    }
    private func disableBtn()
    {
        self.binaryBtn.isEnabled = false
        self.decimalBtn.isEnabled = false
        self.binaryBtn.alpha = 0.5
        self.decimalBtn.alpha = 0.5
    }
    private func enableBtn(){
        self.binaryBtn.isEnabled = true
        self.decimalBtn.isEnabled = true
        self.binaryBtn.alpha = 1
        self.decimalBtn.alpha = 1
    }
    @IBAction func binaryBtnWasPressed(_ sender: Any) {
        if valueEntrytxtField.text != "" {
            binaryBtn.alpha = 1
            decimalBtn.alpha = 0.5
            guard let string = valueEntrytxtField.text, let intFromString = Int(string) else { return }
            let binaryDigit = BinaryDecimal(intFromString)
            valueEntrytxtField.text = "\(binaryDigit.calculateBinaryValueForInt())"
        }
    }
    
    @IBAction func decimalBtnWasPressed(_ sender: Any) {
        if valueEntrytxtField.text != "" {
            binaryBtn.alpha = 0.5
            decimalBtn.alpha = 1
            guard let string = valueEntrytxtField.text, let intFromString = Int(string) else { return }
            let bitsFromString = string.map({Int(String($0))!})
            let binaryDigit = BinaryDecimal(bitsFromString)
            valueEntrytxtField.text = "\(binaryDigit.calculateIntValueForBinary())"
        }
    }
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.valueEntrytxtField.placeholder = ""
        return true
    }
}

