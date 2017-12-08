//
//  BColor.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/3/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import UIKit

struct ColorResultWrapper: Codable {
    let colors: [BColor]
}

struct BColor: Codable {
    let hex: String
    let tags: [Tag]
    
    // I think this should be in the viewModel
    var name: String {
        let title = tags.reduce("") { $0 + " " + $1.name }
        return title.isEmpty ? "No Name" : title
    }
    
    struct Tag: Codable {
        let name: String
    }
}


