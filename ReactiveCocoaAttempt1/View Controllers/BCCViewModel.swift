//
//  BCCViewModel.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/3/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
//import UIKit
import Result

class BCCViewModel: NSObject {
    
    var currentColor: BColor? {
        didSet {
            if let color = currentColor {
                // Mutable Properties
//                self.currentColorDisplayTextMP.value = color.name
//                self.currentColorHexValueMP.value = color.hex
//                self.backgroundColorMP.value = UIColor(hexString: color.hex)
                
                // Signal
                // emit some kind of signal that the VC recievs to update the UI
                self.currentColorName = color.name
                self.currentColorHex = color.hex
                self.colorUpdatePipe.input.send(value: ())
            }
        }
    }
    
    var currentColorName: String = "white"
    var currentColorHex: String = "ffffff"
    
    
    var isLoading: Bool = false

//    let currentColorDisplayTextMP = MutableProperty("white")
//    let currentColorHexValueMP = MutableProperty("ffffff")
    
//    let backgroundColorMP = MutableProperty(UIColor(hexString: "ffffff"))
    
    
//    let colorTextFieldValuePipe = Signal<String?, NoError>.pipe()
//    var colorTextFieldValueSignal: Signal<String?, NoError>!
    
    
    let colorUpdatePipe = Signal<Void, NoError>.pipe()
    
    override init() {
        super.init()
        
        
    }
    
    func newColor() {
        isLoading = true
        ColorManager.shared.changeColor { (color) in
            self.isLoading = false
            self.currentColor = color
        }
    }
    
}
