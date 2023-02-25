//
//  ToDoRowView.swift
//  DontForget
//
//  Created by Rafał on 25/02/2023.
//

import SwiftUI

struct RowView: View {
    
    @State var model: ToDoModel
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(model.name)")
                    .font(.title2)
                    .lineLimit(1)
                
                if let description = model.description {
                    Text(description)
                        .font(.caption)
                        .bold()
                        .lineLimit(2)
                }
            }
            Spacer()
            Text("Go to \(model.name)")
                .foregroundColor(.white)
                .font(.caption)
            
        }
        .frame(maxWidth: .infinity)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(model: (ToDoModel(name: "Gym", description: "XD", listItems: [Item(itemName: "Spodenki", itemState: false)])))
    }
}
