//
//  BCCViewController.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/3/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class BCCViewController: UIViewController {
    
    var viewModel: BCCViewModel!
    
    @IBOutlet weak var backgroundColorChangeButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        self.viewModel = BCCViewModel()
        super.viewDidLoad()
        
        navigationItem.reactive.title <~ viewModel.currentColorDisplayText
        view.reactive.backgroundColor <~ viewModel.currentColorHexValue.map { UIColor(hexString: $0) }
        activityIndicator.reactive.isAnimating <~ viewModel.isLoading
        backgroundColorChangeButton.reactive.isEnabled <~ viewModel.isLoading.map { !$0 }
        addFavoriteButton.reactive.pressed = CocoaAction(viewModel.saveColorAction)
        backgroundColorChangeButton.reactive.pressed = CocoaAction(viewModel.newColorAction)
    }
}
