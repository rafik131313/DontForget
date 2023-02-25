//
//  ToDoAddSheetView.swift
//  DontForget
//
//  Created by Rafał on 25/02/2023.
//

import SwiftUI

struct ToDoAddSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var todoVM = ToDoViewModel()
    
    @State var name: String = ""
    @State var description: String = ""
    @State var itemName: String = ""
    @State var itemsList: [String] = []
    
    @State var doubleItemNameError: Bool = false
    @State var emptyItemNameError: Bool = false
    @State var showDoubleItemAlert: Bool = false
    @State var showAddAlert: Bool = false
    
    let haptics = HapticsManager.instance
    
    let gradient = LinearGradient(colors: [.blue.opacity(0.8), .green.opacity(0.2)],
                                  startPoint: .topLeading, endPoint: .bottomTrailing)
    
    
    var body: some View {
        ZStack{
            gradient
            VStack{
                VStack(alignment: .leading){
                    
                    nameSection
                    
                    descriptionSection
                    
                    itemsSectionHeader
                    
                    HStack{
                        
                        itemsSectionTextField
                        
                        addItemButton
                    }
                    .padding(.horizontal)
                    
                    itemsScrollView
                    
                }
                .padding(.horizontal)
                
                HStack(){
                    
                    deleteItemsButton
                    
                    saveButton
                    
                }
                Spacer()
            }
            .padding(.vertical, 40)
            .alert(Text("Hey!"), isPresented: $showAddAlert, actions: {
                //
            }, message: {
                Text("Name and Item are required!😛")
            })
            
            .alert(Text("Something went wrong!"), isPresented: $showDoubleItemAlert, actions: {
                Button {
                    itemName = ""
                } label: {
                    Text("I'm sorry 🥺")
                }
            }, message: {
                Text("You can't add two same items 😅")
            })
        }
        .ignoresSafeArea()
    } //body end
    
    var nameSection: some View {
        VStack(alignment: .leading){
            Text("Name:")
                .fontWeight(.semibold)
                .padding(.top, 50)
            TextField("Name (required)", text: $name)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(colors: [.green.opacity(0.7), .green.opacity(0.6), .blue.opacity(0.4)],
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                .padding()
        }
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading){
            Text("Description:")
                .fontWeight(.semibold)
            TextField("Description", text: $description)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(colors: [.purple.opacity(0.8), .purple.opacity(0.6), .blue.opacity(0.4)],
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                .padding()
        }
    }
    
    var itemsSectionHeader: some View {
        Text("Items:")
            .fontWeight(.semibold)
            .onTapGesture {
                itemsList.append("")
            }
    }
    
    var itemsSectionTextField: some View {
        TextField("Item", text: $itemName)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(colors: [.orange.opacity(0.8), .orange.opacity(0.6), .orange.opacity(0.6), .blue.opacity(0.4), .blue.opacity(0.6)],
                                         startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            .padding()
    }
    
    var addItemButton: some View {
        Image(systemName: "plus")
            .padding()
            .background(
                Circle()
                    .fill(emptyItemNameError ? .red : .blue.opacity(0.7))
            )
            .offset(x: doubleItemNameError ? -3 : 0)
            .onTapGesture {
                
                // Empty itemName -> + button changing color + haptics
                if itemName.count < 1 {
                    withAnimation {
                        emptyItemNameError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            emptyItemNameError = false
                        }
                        haptics.makeHaptics(result: .failure)
                    }
                    // itemName is in itemList already -> + button vibrations + haptics + error
                } else if itemsList.contains( itemName ){
                    withAnimation(.default) {
                        doubleItemNameError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            doubleItemNameError = false
                        }
                    }
                    haptics.makeHaptics(result: .failure)
                    showDoubleItemAlert.toggle()
                }
                //Everything should be fine add to itemList
                else {
                    itemsList.insert( itemName, at: 0)
                    itemName = ""
                    haptics.makeHaptics(result: .success)
                }
            }
            .frame(width: 70)
    }
    
    var itemsScrollView: some View {
        ScrollView {
            VStack(alignment: .center){
                ForEach(itemsList, id: \.self) { item in
                    Text(item)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxHeight: 250)
        .padding()
    }
    
    var deleteItemsButton: some View {
        Button {
            itemsList = []
            haptics.makeHaptics(result: .success)
        } label: {
            Text("Delete Items")
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.red)
                )
        }
    }
    
    var saveButton: some View{
        Button {
            
            if !name.isEmpty && itemsList.count > 0 {
                todoVM.addItemDataToFileManager(key: name, item: ToDoModel(name: name, description: description), itemsList: itemsList)
                haptics.makeHaptics(result: .success)
                dismiss()
            } else {
                showAddAlert.toggle()
                haptics.makeHaptics(result: .failure)
            }
            
        } label: {
            Text("Add")
                .foregroundColor(.white)
                .font(.title2)
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.green)
                }
        }
        .padding(.horizontal)
    }
    
    
}

struct ToDoAddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoAddSheetView()
    }
}
