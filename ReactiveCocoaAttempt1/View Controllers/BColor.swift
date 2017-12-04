//
//  BColor.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/3/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation

struct ColorResultWrapper: Codable {
    let colors: [BColor]
}

struct BColor: Codable {
    let hex: String
    let tags: [Tag]
    
    struct Tag: Codable {
        let name: String
    }
}




