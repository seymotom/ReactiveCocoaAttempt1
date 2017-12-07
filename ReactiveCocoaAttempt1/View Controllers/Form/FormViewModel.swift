//
//  FormViewModel.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/7/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class FormViewModel {
    
    let firstNameMP = MutableProperty<String>("")
    let lastNameMP = MutableProperty<String>("")
    let emailMP = MutableProperty<String>("")
    let progress = MutableProperty<Float>(0.0)
    private let isValid = MutableProperty<Bool>(false)
    
    lazy var submit: Action <Void, Void, NoError> = {
        return Action(enabledIf: self.isValid, execute: { _ in
            return SignalProducer<Void, NoError> { [weak self] observable, _ in
                print("""
                    First: \(self?.firstNameMP.value ?? "")
                    Last: \(self?.lastNameMP.value ?? "")
                    Email: \(self?.emailMP.value ?? "")
                    """)
            }
        })
    }()
    
    init() {
        self.isValid <~ SignalProducer.combineLatest(self.firstNameMP, self.lastNameMP, self.emailMP).map{ (first, last, email) in
            return (!first.isEmpty && !last.isEmpty && !email.isEmpty) && email.count >= 5
        }
        
        self.progress <~ SignalProducer.combineLatest(self.firstNameMP, self.lastNameMP, self.emailMP).map{ (arg) -> Float in
            
            let (first, last, email) = arg
            return Float((!first.isEmpty).hashValue + (!last.isEmpty).hashValue + (!email.isEmpty).hashValue) / 3.0
        }
    }
}
