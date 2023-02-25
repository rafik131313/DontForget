//
//  ImageView.swift
//  DontForget
//
//  Created by Rafał on 26/02/2023.
//

import SwiftUI

struct ImageView: View {
    
    var isLoading: Bool = false
        
    init(){
        
    }

        
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            //image
            }
        }
    }


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
