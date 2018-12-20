//
//  testViewController.swift
//  TestingXIBS
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    let vc = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("here")
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonTapped(_ sender: Any)
    {
        navigationController?.pushViewController(vc, animated: true)
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
