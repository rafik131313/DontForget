//
//  ListModel.swift
//  DontForget
//
//  Created by Rafał on 25/02/2023.
//

import Foundation

struct ToDoModel: Identifiable, Hashable, Codable {
    var id = UUID().uuidString
    var name: String
    var description: String?
    var listItems: [Item] = []
}

struct Item: Hashable, Codable {
    var itemName: String = ""
    var itemState: Bool = false
}
