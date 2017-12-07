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
        
        summaryTV.reactive.text <~ SignalProducer.combineLatest(viewModel.firstNameMP, viewModel.lastNameMP, viewModel.emailMP).map{ (first, last, email) in
            return """
            Name: \(first)
            Last: \(last)
            Email: \(email)
"""
        }
        
        emailTF.reactive.textColor <~ viewModel.emailMP.map{ email in
            if email.count >= 5 {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }

        progressView.reactive.progress <~ viewModel.progress
        
//        progressView.reactive.progress <~ viewModel.firstNameMP.map { first in
//            return (!first.isEmpty).hashValue
//        }.combineLatest(with: viewModel.lastNameMP).map { (arg) -> Int in
//            var (counter, last) = arg
//            counter = counter + (!last.isEmpty).hashValue
//            return counter
//        }.combineLatest(with: viewModel.emailMP).map({ (counter, email) -> (Float) in
//            let counter = counter + (!email.isEmpty).hashValue
//            return Float(counter) / 3.0
//        })
        
//        progressView.reactive.progress <~ SignalProducer.combineLatest(viewModel.firstNameMP, viewModel.lastNameMP, viewModel.emailMP).map{ fields in
//            let (first, last, email) = fields
//
//            var numberOfFields = 0
//            if !first.isEmpty {
//                numberOfFields += 0.33
//            }
//            if !last.isEmpty {
//                numberOfFields += 0.33
//            }
//            if !email.isEmpty {
//                numberOfFields += 0.33
//            }
//
//            return numberOfFields
//        }
        
        
        /*doneButton.reactive.isEnabled <~ viewModel.firstNameMP.combineLatest(with: viewModel.lastNameMP).combineLatest(with: viewModel.emailMP).map { (arg0, email) in

            let (first, last) = arg0
            return !(first ?? "").isEmpty && !(last ?? "").isEmpty && !(email ?? "").isEmpty
        }*/
        
    }
    
    

    

}
