//
//  ColorManager.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveSwift

class ColorManager {
    
    static let shared = ColorManager()
    
    private init() {
        changeColor()
    }
    
    var currentColor = MutableProperty<BColor?>(nil)
    
    func changeColor() {
        APIManager.shared.getData(endpoint: "http://www.colr.org/json/color/random") { (data) in
            if let data = data {
                do {
                    let resultWrapper = try JSONDecoder().decode(ColorResultWrapper.self, from: data)
                    if let color = resultWrapper.colors.first {
                        self.currentColor.value = color
                    }
                }
                catch {
                    print("WHOOPS!!")
                    print(error)
                }
            }
        }
    }
    
}
