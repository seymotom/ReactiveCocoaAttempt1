//
//  FavoritesViewModel.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/6/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class FavoritesViewModel {
    
    private var favColors: [BColor]? {
        didSet {
            contentChangePipe.input.send(value: ())
        }
    }
    
    var contentChangePipe = Signal<Void, NoError>.pipe()
    
    func getFavoriteColors() {
        self.favColors = ColorManager.getFavoriteColors()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsForSection(_ section: Int) -> Int {
        return favColors?.count ?? 0
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> FavoriteCellViewModel? {
        guard let color = favColors?[indexPath.row] else { return nil }
        return FavoriteCellViewModel(color: color)
    }
    
}
