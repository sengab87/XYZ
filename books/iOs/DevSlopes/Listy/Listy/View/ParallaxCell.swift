//
//  ParallaxCell.swift
//  Listy
//
//  Created by Ahmed Sengab on 12/20/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit
import CoreMotion
class ParallaxCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var itemImageView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupParallax()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupParallax()
    {
            let min = CGFloat(-30)
            let max = CGFloat(30)
            let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
            xMotion.minimumRelativeValue = min
            xMotion.maximumRelativeValue = max
            
            let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
            yMotion.minimumRelativeValue = min
            yMotion.maximumRelativeValue = max
            
            let motionEffectGroup = UIMotionEffectGroup()
            motionEffectGroup.motionEffects = [xMotion,yMotion]
            self.itemImageView.addMotionEffect(motionEffectGroup)
    }
    func configureCell(withImage image: UIImage, andDesc description: String)
    {
        self.itemImageView.image = image
        self.descriptionLabel.text = description
    }

}
