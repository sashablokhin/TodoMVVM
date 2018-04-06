//
//  TodoViewModel.swift
//  TodoMVVM
//
//  Created by Alexander Blokhin on 05.04.2018.
//  Copyright © 2018 Develop. All rights reserved.
//

import Foundation

protocol TodoItemViewDelegate {
    func itemSelected()
}

protocol TodoItemPresentable {
    var text: String? { get }
    var date: String? { get }
}

struct TodoItemViewModel: TodoItemPresentable {
    var text: String?
    var date: String?
}

extension TodoItemViewModel: TodoItemViewDelegate {
    func itemSelected() {
        print("itemSelected", text!)
    }
}

protocol TodoViewDelegate {
    func todoItemAdded()
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
    func todoItemAdded() {
        let item = TodoItemViewModel(text: newTodoText, date: currentTime())
        self.items.append(item)
        
        newTodoText = ""
        self.view?.insertTodoItem()
    }
}
