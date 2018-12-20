//
//  ViewController.swift
//  MVVM_Tutorial
//
//  Created by Ahmed Sengab on 12/10/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel : ToDoViewModel?
    @IBOutlet weak var tableViewItems: UITableView!
    @IBOutlet weak var textFieldNewIten: UITextField!
    let identifier = "todoItemCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    let nib = UINib(nibName: "ToDoItemTableViewCell", bundle: nil)
        tableViewItems.register(nib, forCellReuseIdentifier: identifier)
    viewModel = ToDoViewModel()
    }

    @IBAction func addOnItem(_ sender: Any) {
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ToDoItemTableViewCell
        let itemViewModel = viewModel?.items[indexPath.row]
        cell?.configure(withViewModel: itemViewModel!)
        return cell!
    }
    
    
}
