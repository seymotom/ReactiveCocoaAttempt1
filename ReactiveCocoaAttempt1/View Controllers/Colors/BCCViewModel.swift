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
                self.currentColorDisplayText.value = color.name.capitalized
                self.currentColorHexValue.value = color.hex
            }
        }
    }
    
    var isLoading = MutableProperty<Bool>(false)

    let currentColorDisplayText = MutableProperty<String>("White")
    let currentColorHexValue = MutableProperty<String>("ffffff")
    
    let colorTextFieldValuePipe = Signal<String?, NoError>.pipe()
    var colorTextFieldValueSignal: Signal<String?, NoError>!
    
    override init() {
        
    }
    
//    func newColor() {
//        isLoading.value = true
//        ColorManager.changeColor().on(failed: { error in
//            print(error)
//        }, value: { [weak self] (color) in
//            self?.currentColor = color
//            self?.isLoading.value = false
//        }).start()
//    }
    
    
    lazy var newColorAction: Action<Void, Void, NoError> = {
        return Action { _ in
            return SignalProducer<Void, NoError> { observer, _ in
                self.isLoading.value = true
                ColorManager.changeColor().on(failed: { error in
                    print(error)
                }, value: { [weak self] (color) in
                    self?.currentColor = color
                    self?.isLoading.value = false
                }).start()
                observer.sendCompleted()
            }
        }
    }()
    
    lazy var saveColorAction: Action<Void, Void, NoError> = {
        return Action<Void, Void, NoError> { _ in
            
            return SignalProducer<Void, NoError> { observer, _ in
                if let currentColor = self.currentColor {
                    ColorManager.saveColor(currentColor)
                }
                observer.sendCompleted()
            }
        }
    }()
    
    
    
}
