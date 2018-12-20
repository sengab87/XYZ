//
//  CurrencyTxtField.swift
//  WindowShopper
//
//  Created by Ahmed Sengab on 12/18/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTxtField: UITextField {

    override func awakeFromNib() {
        super .awakeFromNib()
        customizeView()
        
    }
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    func customizeView()
    {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2048305458)
        self.layer.cornerRadius = 5.0
        self.textAlignment = .center
        self.keyboardType = .decimalPad
        self.borderStyle = .none
        self.clipsToBounds = true
        if (placeholder == nil)
        {
            placeholder = " "
        }
        let place = NSAttributedString(string: placeholder!, attributes: [.foregroundColor: UIColor.white])
        attributedPlaceholder = place
        textColor = UIColor.white
    }
    override func draw(_ rect: CGRect) {
        // Never implement it when it is empty
        // Never call super
        let size: CGFloat = 20
        let currencyLbl = UILabel(frame: CGRect(x: 5, y: frame.size.height/2 - size/2, width: size, height: size))
        currencyLbl.backgroundColor = #colorLiteral(red: 0.7631019354, green: 0.7574522495, blue: 0.7674265504, alpha: 1)
        currencyLbl.textAlignment = .center
        currencyLbl.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        currencyLbl.layer.cornerRadius = 5
        currencyLbl.clipsToBounds = true
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        currencyLbl.text = formatter.currencySymbol
        addSubview(currencyLbl)
    }

}
