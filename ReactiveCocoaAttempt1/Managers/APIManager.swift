//
//  APIManager.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/4/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import Foundation
import ReactiveSwift
//import Result

enum APIError: Error {
    case jsonError(error: Error)
    case dataMappingError(error: Error)
    case unknown
}

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func getData(endpoint: String) -> SignalProducer<Data, APIError> {
        return SignalProducer { observer, disposable in
            guard let url = URL(string: endpoint) else { return }
                    let request = URLRequest(url: url)
                    let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                        if let myError = error {
                            print(myError)
//                            completionHandler(nil)
                            observer.send(error: APIError.jsonError(error: myError))
                            observer.sendCompleted()
                        }
                        if let myData = data {
//                            completionHandler(myData)
                            observer.send(value: myData)
                            observer.sendCompleted()
                        }
                    }
                    task.resume()
        }
    }
    
//    func getData(endpoint: String, completionHandler: @escaping (Data?)->()) {
//        guard let url = URL(string: endpoint) else { return }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            if let myError = error {
//                print(myError)
//                completionHandler(nil)
//            }
//            if let myData = data {
//                completionHandler(myData)
//            }
//        }
//        task.resume()
//    }
}
