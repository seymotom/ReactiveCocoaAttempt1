//
//  FavoriteTableViewCell.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/6/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    var cellViewModel: FavoriteCellViewModel! {
        didSet {
            self.textLabel?.text = cellViewModel.displayName
            self.backgroundColor = UIColor(hexString: cellViewModel.displayHex)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
}
