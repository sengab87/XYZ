//
//  NvViewController.swift
//  TestingXIBS
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class NvViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationBar.barTintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        print("yp")
        // Do any additional setup after loading the view.
    }
    override func awakeFromNib() {
        super .awakeFromNib()
        
        print("y1p")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
