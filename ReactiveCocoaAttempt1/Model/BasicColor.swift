//
//  BasicColor.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import UIKit

struct BasicColor {
    let color: UIColor
    let name: String
    
    static let colors: [BasicColor] = [
        BasicColor(color: .red, name: "red"),
        BasicColor(color: .blue, name: "blue"),
        BasicColor(color: .yellow, name: "yellow"),
        BasicColor(color: .green, name: "green"),
        BasicColor(color: .purple, name: "purple"),
        BasicColor(color: .orange, name: "orange"),
        BasicColor(color: .black, name: "black"),
        BasicColor(color: .gray, name: "gray"),
        BasicColor(color: .brown, name: "brown"),
        BasicColor(color: .white, name: "white")
    ]
    
    
}
