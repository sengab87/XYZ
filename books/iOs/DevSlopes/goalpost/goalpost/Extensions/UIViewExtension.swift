//
//  UIViewExtension.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/25/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
extension UIView
{
    func bindToKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillChange(_ notification: Notification)
    {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = ((notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey]) as! NSValue).cgRectValue
        let endingFrame = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]) as! NSValue).cgRectValue
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
        
    }
}
