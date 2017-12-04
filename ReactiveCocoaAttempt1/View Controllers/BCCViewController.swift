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

    
    override func viewDidLoad() {
        self.viewModel = BCCViewModel()
        super.viewDidLoad()
                
        backgroundColorChangeButton.reactive.controlEvents(.touchUpInside).observe(on: UIScheduler()).observeValues { [weak self] _ in
            // MARK: - Q1. why is self optional here?
            // because you told the observer it was weak. If the VC gets deinitialized then self would be nil?... though the event will never trigger if the VC is killed

            if let color = self?.viewModel.randColor {
                // don't set the textField text manually, send the value down the pipe
                //self?.viewModel.colorTextFieldValuePipe.input.send(value: color?.name)
                self?.viewModel.currentColorDisplayText.value = color.name
                self?.view.backgroundColor = color.color
            }
        }
        
        // MARK: - Binding the label
        colorLabel.reactive.text <~ viewModel.currentColorDisplayText
        
        
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

    

}
