//
//  HapticsManager.swift
//  DontForget
//
//  Created by Rafał on 04/03/2023.
//

import Foundation
import UIKit

class HapticsManager {
    
    static let instance = HapticsManager()
    
    enum Haptics {
        case success
        case failure
    }
    
    private init(){
        
    }
    
    func makeHaptics(result: Haptics) {
        
        let generator = UINotificationFeedbackGenerator()
        
        switch result {
        case .failure:
            generator.notificationOccurred(.error)
        case .success:
            generator.notificationOccurred(.success)
        }
    }
    
}
