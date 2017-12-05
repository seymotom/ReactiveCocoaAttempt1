//
//  ColorManager.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class ColorManager {
    
    static let shared = ColorManager()
    
    private init() {
//        changeColor()
    }
    
//    var currentColor = MutableProperty<BColor?>(nil)
    
    func changeColor() -> SignalProducer<BColor, APIError> {
        
        return APIManager.shared.getData(endpoint: "http://www.colr.org/json/color/random").attemptMap({ data in
            
            do {
                let resultWrapper = try JSONDecoder().decode(ColorResultWrapper.self, from: data)
                if let color = resultWrapper.colors.first {
                    return Result(value: color)
                }
            }
            catch(let error) {
                print("WHOOPS!!")
                print(error)
                return Result(error: APIError.dataMappingError(error: error))
            }
            
            return Result(error: .unknown)
        })
        
//        APIManager.shared.getData(endpoint: "http://www.colr.org/json/color/random") { (data) in
//            if let data = data {
//                do {
//                    let resultWrapper = try JSONDecoder().decode(ColorResultWrapper.self, from: data)
//                    if let color = resultWrapper.colors.first {
////                        self.currentColor.value = color
//                        completionHandler(color)
//                    }
//                }
//                catch {
//                    print("WHOOPS!!")
//                    print(error)
//                }
//            }
//        }
    }
    
}
