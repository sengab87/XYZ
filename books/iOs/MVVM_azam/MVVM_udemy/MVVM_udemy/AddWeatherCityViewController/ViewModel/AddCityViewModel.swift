//
//  AddCityViewModel.swift
//  MVVM_udemy
//
//  Created by Ahmed Sengab on 12/16/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import Foundation
import UIKit
import ReactiveKit
import Bond


struct AddCityViewModel{
    private var addCityModel : AddCityModel!
    let city : Observable<String?> = Observable(nil)
    let zip : Observable<String?> = Observable(nil)
    let state : Observable<String?> = Observable(nil)
    /*init(){
        self.city = addCityModel.city
        self.zip = addCityModel.zipCode
        self.state = addCityModel.state
    }*/
}
class BindingTextField : UITextField{
    
    var textChangeClosure : (String) -> () = { _ in }
    override init(frame: CGRect){
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    /*private func commonInit(){
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField){
        
        if let text = textField.text
        {
            self.textChangeClosure(text)
            //print(text)
            
        }
    }
    func bind(callback: @escaping (String)-> ()){
        self.textChangeClosure = callback
        }*/
}
