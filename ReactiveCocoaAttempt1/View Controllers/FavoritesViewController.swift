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
    
}
