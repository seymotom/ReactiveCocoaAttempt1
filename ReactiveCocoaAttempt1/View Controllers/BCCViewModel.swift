//
//  BCCViewModel.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/3/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class BCCViewModel: NSObject {
    
    var currentColor: BColor? {
        didSet {
            if let color = currentColor {
                self.currentColorDisplayText.value = color.name
                self.currentColorHexValue.value = color.hex
//                self.backgroundColor.value = UIColor(hexString: color.hex)
            }
        }
    }
    
    var isLoading: Bool = false

    let currentColorDisplayText = MutableProperty<String>("white")
    let currentColorHexValue = MutableProperty<String>("ffffff")
//    let backgroundColor = MutableProperty<UIColor>(UIColor(hexString: "ffffff"))
    
    
    let colorTextFieldValuePipe = Signal<String?, NoError>.pipe()
    var colorTextFieldValueSignal: Signal<String?, NoError>!
    
    override init() {
        
    }
    
    func newColor() {
        isLoading = true
        ColorManager.shared.changeColor().on(failed: { error in
            print(error)
        }, value: { [weak self] (color) in
            self?.currentColor = color
        }).start()
        
//            {
//                (color) in
//            self.isLoading = false
//            self.currentColor = color
//        }
    }
    
}
