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
    func todoItemAdded()
}

struct TodoViewModel {
    var newTodoItem: String?
    var items = [TodoItemPresentable]()
    
    func currentTime() -> String {
        return DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    }
    
    init() {
        let item1 = TodoItemViewModel(text: "Item1", date: currentTime())
        let item2 = TodoItemViewModel(text: "Item2", date: currentTime())
        let item3 = TodoItemViewModel(text: "Item3", date: currentTime())
        
        items.append(contentsOf: [item1, item2, item3])
    }
}

extension TodoViewModel: TodoItemViewDelegate {
    func todoItemAdded() {
        
    }
}
