//
//  RoundedVisualEffectView.swift
//  Animals
//
//  Created by Ahmed Sengab on 1/20/19.
//  Copyright © 2019 Ahmed Sengab. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedVisualEffectView: UIVisualEffectView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    private func setupView(){
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
