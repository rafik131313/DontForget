//
//  TestView.swift
//  DontForget
//
//  Created by Rafał on 04/03/2023.
//

import SwiftUI

struct TestView: View {
    var body: some View {
         NavigationStack {
             ZStack {
                 Color.green
                     .opacity(0.1)
                     .ignoresSafeArea()
                 
                 VStack {
                     Rectangle()
                         .fill(Color.clear)
                         .frame(height: 10)
                         .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                                    startPoint: .topLeading, endPoint: .bottomTrailing)
                         )
                     
                     Text("Have the style touching the safe area edge.")
                         .padding()
                     Spacer()
                 }
                 .navigationTitle("Nav Bar Background")
                 .font(.title2)
             }
         }
     }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
