//
//  ToDoViewModel.swift
//  MVVM_Tutorial
//
//  Created by Ahmed Sengab on 12/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

protocol TodoItemPresentable{
    var textValue : String?{get}
    var id : String?{get}
}
protocol ToItemViewDelegate {
    func onToDoItemAdded() -> ()
}
struct ToDoItemViewModel : TodoItemPresentable{
    var id : String? = "0"
    var textValue: String?
    
}
struct ToDoViewModel {
    init(){
        let item1 = ToDoItemViewModel(id: "1", textValue: "Washing Clothese")
        let item2 = ToDoItemViewModel(id: "2", textValue: "Buy Groceries")
        let item3 = ToDoItemViewModel(id: "3", textValue: "Wash Car")
        items.append(contentsOf: [item1,item2,item3])
    }
    var newToDoItem : String?
    var items : [TodoItemPresentable] = []
}
extension ToDoViewModel: ToItemViewDelegate{
    func onToDoItemAdded() {
        //
    }
}
