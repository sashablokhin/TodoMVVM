//
//  ViewController.swift
//  TodoMVVM
//
//  Created by Develop on 4/5/18.
//  Copyright © 2018 Develop. All rights reserved.
//

import UIKit

protocol TodoView: class {
    func insertTodoItem()
}

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TodoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodoViewModel(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addButtonClicked(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else {return}
        viewModel.todoItemAdded(newTodoText: text)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoItemTableViewCell
        let item = viewModel.items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension ViewController: TodoView {
    func insertTodoItem() {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: viewModel.items.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }  
}








