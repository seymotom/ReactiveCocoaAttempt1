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
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var backgroundColorChangeButton: UIButton!

    @IBOutlet weak var hexLabel: UILabel!
    
    @IBOutlet weak var addFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        self.viewModel = BCCViewModel()
        super.viewDidLoad()
                
//        backgroundColorChangeButton.reactive.controlEvents(.touchUpInside).observe(on: UIScheduler()).observeValues { [weak self] _ in
//            self?.viewModel.newColor()
//        }
        
        // MARK: - Binding the label
        colorLabel.reactive.text <~ viewModel.currentColorDisplayText
        
        view.reactive.backgroundColor <~ viewModel.currentColorHexValue.map({ hex in
            return UIColor(hexString: hex) 
        })
        
        hexLabel.reactive.text <~ viewModel.currentColorHexValue
        
        activityIndicator.reactive.isAnimating <~ viewModel.isLoading
        backgroundColorChangeButton.reactive.isEnabled <~ viewModel.isLoading.map { !$0 }
        
        
        addFavoriteButton.reactive.pressed = CocoaAction(viewModel.saveColorAction)
        
        backgroundColorChangeButton.reactive.pressed = CocoaAction(viewModel.newColorAction)
        
        
        
        // MARK: - Binding the textField
        
        // https://stackoverflow.com/questions/41488950/how-do-you-get-a-signal-every-time-a-uitextfield-text-property-changes-in-reacti
        // Bind the text of the text field to the signal pipe's output
        colorTextField.reactive.text <~ viewModel.currentColorDisplayText //viewModel.colorTextFieldValuePipe.output
        // A signal of text values emitted by the text field upon end of editing.
        let ctfValuesSignal = colorTextField.reactive.textValues
        // A signal of text values emitted by the text field upon any changes.
        let ctfContinuousValuesSignal = colorTextField.reactive.continuousTextValues
        // Merge the relevant signals
        viewModel.colorTextFieldValueSignal = Signal.merge(ctfValuesSignal, ctfContinuousValuesSignal)
    
        // This will update the label when the textField's value is changed by the user or programmatically
        viewModel.colorTextFieldValueSignal.observeValues { (value) in
            self.viewModel.currentColorDisplayText.value = value ?? ""
        }
        
        
        
    }
    
    
//    @IBAction func addPressed(_ sender: UIBarButtonItem) {
//        viewModel.saveColor()
//    }
    
    

}
