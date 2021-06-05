//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Ahmed Sengab on 6/2/21.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var taskViewModel: TaskListViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
