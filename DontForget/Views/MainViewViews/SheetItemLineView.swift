//
//  SheetItemLineView.swift
//  DontForget
//
//  Created by Rafał on 03/03/2023.
//

import SwiftUI

struct SheetItemLineView: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 0){
            TextField("itemName", text: $text)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                )
                .padding(.horizontal)
        }
    }
}

struct SheetItemLineView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(){
            SheetItemLineView(text: .constant(""))
            SheetItemLineView(text: .constant(""))
        }
    }
}
