//
//  ToDoView.swift
//  DontForget
//
//  Created by Rafał on 01/03/2023.
//

import SwiftUI

struct ToDoView: View {
    
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var todoVM = ToDoViewModel()
    
    @State var toDoModel: ToDoModel

    
    let gradientLight = LinearGradient(colors: [.white.opacity(0.5), .blue.opacity(0.2), .blue.opacity(0.6)],
                                       startPoint: .topLeading, endPoint: .trailing)
    
    let gradientDark = LinearGradient(colors: [.blue.opacity(0.1), .blue.opacity(0.6), .blue.opacity(0.7), .blue.opacity(0.8)],
                                      startPoint: .topLeading, endPoint: .trailing)
    
    var body: some View {
        
        ZStack {
            
            gradientLight.ignoresSafeArea()
            
            VStack {
                
                Divider().background(Double(weatherVM.getTemperature()) ?? 0 > 0 ? gradientLight : gradientDark)
                
                HStack {
                    VStack(alignment: .leading) {
                        List{
                            ForEach($toDoModel.listItems, id: \.self) { item in
                                
                                ToDoRowView(item: item, model: $toDoModel)
                                
                            }
                            .listRowBackground(Color.blue.opacity(0.4))
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.insetGrouped)
                        
                        HStack{
                            Spacer()
                            Button {
                                
                                toDoModel.listItems = toDoModel.listItems.map { item in
                                    var updatedItem = item
                                    updatedItem.itemState = false
                                    return updatedItem
                                }
                                
                                todoVM.updateAllItemsStateInFileManager(modelName: toDoModel.name, items: toDoModel.listItems)
                                
                            } label: {
                                Text("Uncheck All")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                    )
                            }
                            .padding()
                        }
                    }
                    .navigationTitle(toDoModel.name)
                    
                    .toolbar {
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack{
                                Spacer()
                                HStack{
                                    Text(weatherVM.getTemperature())
                                        .bold()
                                        .padding(.trailing, 10)
                                    Image(weatherVM.getWeatherIconName())
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
          //  ToDoView(toDoModel: (ToDoModel(name: "Siłownia", description: "Co zabrać", listItems: [Item(itemName: "ręcznik", itemState: false)])))
        }
        .navigationTitle("Siłownia")
    }
}
