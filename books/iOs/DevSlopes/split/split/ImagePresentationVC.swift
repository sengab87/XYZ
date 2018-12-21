//
//  DetailViewController.swift
//  split
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ImagePresentationVC: UIViewController {

    @IBOutlet weak var itemImageView : UIImageView!
    var image : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImageView.image = self.image
        // Do any additional setup after loading the view, typically from a nib.
    }

}

