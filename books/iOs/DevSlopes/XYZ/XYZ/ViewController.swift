//
//  ViewController.swift
//  XYZ
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var xLabel : UILabel!
    @IBOutlet weak var yLabel : UILabel!
    @IBOutlet weak var zLabel : UILabel!
    
    var motionManager : CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates(to: .main, withHandler: updateLabels)
    }
    func updateLabels(data: CMAccelerometerData?,error: Error?)
    {
        guard let accelometerData = data else {return
        }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        let x = formatter.string(for: accelometerData.acceleration.x)!
        let y = formatter.string(for: accelometerData.acceleration.y)!
        let z = formatter.string(for: accelometerData.acceleration.z)!
        xLabel.text = "X: \(x)"
        yLabel.text = "X: \(y)"
        zLabel.text = "X: \(z)"
        
        
    }

}

