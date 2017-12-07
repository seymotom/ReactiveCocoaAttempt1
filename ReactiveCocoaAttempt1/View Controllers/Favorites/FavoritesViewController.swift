//
//  FavoritesViewController.swift
//  ReactiveCocoaAttempt1
//
//  Created by Tom Seymour on 12/6/17.
//  Copyright © 2017 Tom Seymour. All rights reserved.
//

import UIKit
import ReactiveSwift

class FavoritesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FavoritesViewModel!
    
    
    override func viewDidLoad() {
        viewModel = FavoritesViewModel()
        super.viewDidLoad()

        tableView.dataSource = self
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.contentChangePipe.output.observeValues { (_) in
            self.tableView.reloadData()
        }
        
        viewModel.getFavoriteColors()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.setEditing(editing, animated: animated)

    }
    

}

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoriteTableViewCell {
            if let cellViewModel = viewModel.getCellViewModel(for: indexPath) {
                cell.cellViewModel = cellViewModel
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//            viewModel.removeColor(at: indexPath)
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath], with: .middle)
//            tableView.endUpdates()
//        }
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeColor(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
