//
//  TodoViewModel.swift
//  TodoMVVM
//
//  Created by Alexander Blokhin on 05.04.2018.
//  Copyright © 2018 Develop. All rights reserved.
//

import Foundation

protocol TodoMenuItemViewPresentable {
    var title: String? { get }
    var backColor: String? { get }
}

protocol TodoMenuItemViewDelegate {
    func menuItemSelected(row: Int)
}

class TodoMenuItemViewModel: TodoMenuItemViewPresentable, TodoMenuItemViewDelegate {
    var title: String?
    var backColor: String?
    weak var parent: TodoItemViewDelegate?
    
    init(parentViewModel: TodoItemViewDelegate) {
        self.parent = parentViewModel
    }
    
    func menuItemSelected(row: Int) {
        
    }
}

class RemoveMenuItemViewModel: TodoMenuItemViewModel {
    override func menuItemSelected(row: Int) {
        parent?.removeSelected(row: row)
    }
}

class DoneMenuItemViewModel: TodoMenuItemViewModel {
    override func menuItemSelected(row: Int) {
        parent?.doneSelected(row: row)
    }
}

protocol TodoItemViewDelegate: class {
    func itemSelected()
    func removeSelected(row: Int)
    func doneSelected(row: Int)
}

protocol TodoItemPresentable {
    var text: String? { get }
    var date: String? { get }
    var menuItems: [TodoMenuItemViewPresentable]? { get }
}

class TodoItemViewModel: TodoItemPresentable {
    var text: String?
    var date: String?
    var menuItems: [TodoMenuItemViewPresentable]? = []
    weak var parent: TodoViewDelegate?
    
    init(text: String, date: String, parentViewModel: TodoViewDelegate) {
        self.text = text
        self.date = date
        self.parent = parentViewModel
        
        let removeMenuItem = RemoveMenuItemViewModel(parentViewModel: self)
        removeMenuItem.title = "Remove"
        removeMenuItem.backColor = "ff0000"
        
        let doneMenuItem = DoneMenuItemViewModel(parentViewModel: self)
        doneMenuItem.title = "Done"
        doneMenuItem.backColor = "008000"
        
        self.menuItems?.append(contentsOf: [removeMenuItem, doneMenuItem])
    }
}

extension TodoItemViewModel: TodoItemViewDelegate {
    func itemSelected() {
        print("itemSelected", text!)
    }
    
    func removeSelected(row: Int) {
        parent?.itemRemoved(row: row)
    }
    
    func doneSelected(row: Int) {
        parent?.itemDone(row: row)
    }
}

protocol TodoViewDelegate: class {
    func itemAdded()
    func itemRemoved(row: Int)
    func itemDone(row: Int)
}

protocol TodoViewPresentable {
    var newTodoText: String? { get }
}

class TodoViewModel: TodoViewPresentable {
    weak var view: TodoView?
    
    var newTodoText: String?
    var items = [TodoItemPresentable]()
    
    func currentTime() -> String {
        return DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    }
    
    init(view: TodoView) {
        self.view = view
    }
}

extension TodoViewModel: TodoViewDelegate {
    func itemAdded() {
        let item = TodoItemViewModel(text: newTodoText!, date: currentTime(), parentViewModel: self)
        self.items.append(item)
        
        newTodoText = ""
        self.view?.insertTodoItem()
    }
    
    func itemRemoved(row: Int) {
        self.items.remove(at: row)
        self.view?.removeTodoItem(row: row)
    }
    
    func itemDone(row: Int) {
        
    }
}





