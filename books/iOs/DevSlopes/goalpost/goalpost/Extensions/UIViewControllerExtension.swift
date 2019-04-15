//
//  UIViewControllerExtension.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/25/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
extension UIViewController{
    func presentDetail(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition,forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition,forKey: kCATransition)
        dismiss(animated: true, completion: nil)
    }
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        guard let presentedViewController = presentedViewController else { return }
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition,forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
        
        
    }
}
