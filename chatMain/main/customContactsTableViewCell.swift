//
//  customContactsTableViewCell.swift
//  chatMain
//
//  Created by Ahmed Sengab on 11/5/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class customContactsTableViewCell: UITableViewCell {


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        let screenWidth = UIScreen.main.bounds.width
        super.layoutSubviews()
        cellView.frame = CGRect(x: 8, y: 0, width: 44, height: 44)
        cellView.layer.cornerRadius = 22
        cellView.clipsToBounds = true
        let red:CGFloat = 67.4512825906277/255.0
        let green:CGFloat = 215.241137444973/255.0
        let blue:CGFloat = 108.674077391624/255.0
        cellView.backgroundColor =  UIColor(red: red, green: green, blue: blue, alpha: 0.5)
        //cellView.layer.cornerRadius = 25
        //cellView.clipsToBounds = true
        contentView.addSubview(cellView)
        self.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        name.frame = CGRect(x: 65, y: 0, width: screenWidth , height: 22)
        contentView.addSubview(name)
        presence.frame = CGRect(x: 65, y: 24, width: screenWidth, height: 20)
        contentView.addSubview(presence)
        presence.font = UIFont(name: "Arial", size: 14)
        cellView.addSubview(intials)
        intials.textAlignment = NSTextAlignment.center
        intials.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
    }
    var intials = UILabel()
    var cellView = UIImageView()
    var name = UILabel()
    var presence = UILabel()

}
