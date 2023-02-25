//
//  ToDoRowView.swift
//  DontForget
//
//  Created by Rafał on 01/03/2023.
//

import SwiftUI

struct ToDoRowView: View {
    
    @StateObject var todoVM = ToDoViewModel()
    
    let haptics = HapticsManager.instance
    
    @Binding var item: Item
    
    @Binding var model: ToDoModel
    
    var body: some View {
        HStack {
            Image(systemName: item.itemState ? "circle.fill" : "circle")
            Text(item.itemName)
        }
        .font(.title2)
        .onTapGesture {
            item.itemState.toggle()
            todoVM.updateCurrentItemStateInFileManager(modelName: model.name, item: item)
            haptics.makeHaptics(result: .success)
        }
    }
}

struct ToDoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoRowView(item: .constant(Item()), model: .constant(ToDoModel(name: "adsasd")))
    }
}
