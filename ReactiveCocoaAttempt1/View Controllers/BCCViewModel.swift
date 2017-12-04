//
//  BCCViewModel.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/3/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class BCCViewModel: NSObject {
    
//    let currentColorDisplayText = MutableProperty(ColorManager.shared.currentColor.value?.name ?? "")
//    let currentColorHexValue = MutableProperty(ColorManager.shared.currentColor.value?.hex ?? "ffffff")
    
    let currentColorDisplayText = MutableProperty("white")
    
        
    var currentColor = BasicColor(color: .white, name: "white")
    
    
    let colorTextFieldValuePipe = Signal<String?, NoError>.pipe()
    var colorTextFieldValueSignal: Signal<String?, NoError>!

    
    
    override init() {
        
    }
    
    var randColor: BasicColor {
        currentColor = BasicColor.colors[Int(arc4random_uniform(UInt32(BasicColor.colors.count - 1)))]
        return currentColor
    }
}
