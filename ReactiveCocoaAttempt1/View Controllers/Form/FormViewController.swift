//
//  FormViewController.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/7/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class FormViewController: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var summaryTV: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var viewModel: FormViewModel!
    
    override func viewDidLoad() {
        self.viewModel = FormViewModel()
        super.viewDidLoad()
        
        viewModel.firstNameMP <~ firstNameTF.reactive.continuousTextValues.map { $0 ?? "" }
        viewModel.lastNameMP <~ lastNameTF.reactive.continuousTextValues.map { $0 ?? "" }
        viewModel.emailMP <~ emailTF.reactive.continuousTextValues.map { $0 ?? "" }
        
        doneButton.reactive.pressed = CocoaAction(viewModel.submit)
        
        summaryTV.reactive.text <~ viewModel.summaryTextMP
        emailTF.reactive.textColor <~ viewModel.emailTextColoMP
        progressView.reactive.progress <~ viewModel.progressMP
    }
}
