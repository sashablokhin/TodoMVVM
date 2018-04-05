//
//  TodoViewModel.swift
//  TodoMVVM
//
//  Created by Alexander Blokhin on 05.04.2018.
//  Copyright © 2018 Develop. All rights reserved.
//

import Foundation

protocol TodoItemPresentable {
    var text: String? { get }
    var date: String? { get }
}

struct TodoItemViewModel: TodoItemPresentable {
    var text: String?
    var date: String?
}

protocol TodoItemViewDelegate {
    func todoItemAdded(newTodoText: String)
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

extension TodoViewModel: TodoItemViewDelegate {
    func todoItemAdded(newTodoText: String) {
        let item = TodoItemViewModel(text: newTodoText, date: currentTime())
        self.items.append(item)
        self.view?.insertTodoItem()
    }
}
