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
    func removeTodoItem(row: Int)
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
        viewModel.newTodoText = text
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.itemAdded()
        }
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
        let item = viewModel.items[indexPath.row] as? TodoItemViewDelegate
        item?.itemSelected()
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
        let item = viewModel.items[indexPath.row]
        
        var menuActions = [UIContextualAction]()
        
        _ = item.menuItems?.map({ menuItem in
            let menuAction = UIContextualAction(style: .normal, title: menuItem.title!) { (action, view, success) in
                
                if let delegate = menuItem as? TodoMenuItemViewDelegate {
                    DispatchQueue.global(qos: .background).async {
                        //self.viewModel.itemRemoved(row: indexPath.row)
                        delegate.menuItemSelected()
                    }
                }

                success(true)
            }
            
            menuAction.backgroundColor = UIColor(hex: menuItem.backColor!)
            menuActions.append(menuAction)
        })
        
    
        return UISwipeActionsConfiguration(actions: menuActions)
    }
}


extension ViewController: TodoView {
    func insertTodoItem() {
        OperationQueue.main.addOperation {
            self.textField.text = self.viewModel.newTodoText
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.viewModel.items.count - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func removeTodoItem(row: Int) {
        OperationQueue.main.addOperation {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}








