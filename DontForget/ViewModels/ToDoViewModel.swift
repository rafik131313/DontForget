//
//  ToDoViewModel.swift
//  DontForget
//
//  Created by Rafał on 25/02/2023.
//

import Foundation
import Combine
import UIKit

class ToDoViewModel: ObservableObject {
    
    let fileManager = ToDoFileManager.instance
    
    @Published var toDoArray: [ToDoModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        fileManager.getAllToDoItems()
        addSubscribers()
    }
    
    func addSubscribers(){
        fileManager.$currentToDoArray
            .sink { data in
                DispatchQueue.main.async {
                    self.toDoArray = data
                }
            }
            .store(in: &cancellables)
    }
    
    
    func addItemDataToFileManager(key: String, item: ToDoModel, itemsList: [String]){
        
        var toDoModel = item
        
//        if toDoModel.description == "" {
//            toDoModel.description = nil
//        }
        
        var items: [Item] {
            itemsList.map { itemName in
                Item(itemName: itemName, itemState: false)
            }
        }
        
        toDoModel.listItems.append(contentsOf: items)
        
        fileManager.addToFileManager(key: key, item: toDoModel)
        
    }
    
    
    func delete(at offsets: IndexSet) {
        self.toDoArray.remove(atOffsets: offsets)
        fileManager.deleteFromFileManager(at: offsets)
    }
    
    //    func addModelItemToFileManager(model: ToDoModel, itemName: String){
    //        fileManager.updateCurrentToDoModelItemList(model: model, itemName: itemName)
    //        fileManager.getAllToDoItems()
    //    }
    
    func updateCurrentItemStateInFileManager(modelName: String, item: Item){
        
        var currentModel = fileManager.getModelFromFileManager(key: modelName)
        
        var newModel: ToDoModel = ToDoModel(name: "NEWMODEL")
        
        if let index = currentModel?.listItems.firstIndex(where: { $0.itemName == item.itemName}) {
            currentModel?.listItems[index].itemState = item.itemState
            newModel = currentModel ?? ToDoModel(name: "Error")
        }else{
            print("Error while firstindex \(newModel.name)")
        }
        
        fileManager.updateCurrentToDoModelItemList(model: newModel)
        
    }
    
    func updateAllItemsStateInFileManager(modelName: String, items: [Item]){
        
        var listOfItems = items
        var updatedListOfItems: [Item] = []
        
        for i in 0..<listOfItems.count {
            listOfItems[i].itemState = false
        }
        
        /*
         Alternative:
         toDoModel.listItems = toDoModel.listItems.map { item in
             var updatedItem = item
             updatedItem.itemState.toggle()
             return updatedItem
         }
         */
        
        updatedListOfItems = listOfItems
        
        var currentModel = fileManager.getModelFromFileManager(key: modelName)
        
        currentModel?.listItems = updatedListOfItems
        
        if let model = currentModel {
            fileManager.updateCurrentToDoModelItemList(model: model)
        }
        
    }
    
    func getCurrentModelData(modelName: String) -> ToDoModel?{
        
        return fileManager.getModelFromFileManager(key: modelName)
        
    }
    
    
}

