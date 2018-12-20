//
//  ViewController.swift
//  enumerations
//
//  Created by Ahmed Sengab on 12/13/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
enum Beverage: Int , CaseIterable {
    case coffee, tea, juice
}
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        var as1 = ASCIIControlCharacter.tab
        print(as1.rawValue,"jk")
        var venu = Planet.venus
        print(venu.rawValue)
        print(Beverage.juice.rawValue)
        let plan = Planet(rawValue: 7)
        print(plan)
    }


}

