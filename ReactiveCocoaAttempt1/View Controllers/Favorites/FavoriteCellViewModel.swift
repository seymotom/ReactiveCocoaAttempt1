//
//  FavoriteCellViewModel.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/6/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation

struct FavoriteCellViewModel {
    
    private var color: BColor!
    
    var displayName: String {
        return self.color.name.capitalized
    }
    
    var displayHex: String {
        return self.color.hex
    }
    
    init(color: BColor) {
        self.color = color
    }
}
