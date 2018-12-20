//
//  ToDoItemTableViewCell.swift
//  MVVM_Tutorial
//
//  Created by Ahmed Sengab on 12/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var txtIndex: UILabel!
    @IBOutlet weak var toDoItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// This is to configure cell using the view model
    ///
    /// - Parameter viewModel: return (void)
    func configure(withViewModel viewModel: TodoItemPresentable) -> (){
        self.txtIndex.text = viewModel.id
        self.toDoItem.text = viewModel.textValue
    }
    
}
