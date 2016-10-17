//
//  FoodSearchTableViewController.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 15/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import UIKit

class FoodSearchTableViewController: UITableViewController {
    
    var foods: [Food] = []
    var dataManager: DataManager!
    var filteredFood: [Food] = []
    var searchController: UISearchController!
    var delegate: SearchTableDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods = try! dataManager.getFoods()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFood.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        let food = filteredFood[indexPath.row]
        
        cell.textLabel?.text = food.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = filteredFood[indexPath.row]
        // Use search presentation context to push detail view controller correctly on the navigation stack
        delegate.didSelectFood(food: food)
    }
    
}

extension FoodSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredFood = foods.filter({ food in
            guard let title = food.title,
                let searchText = searchController.searchBar.text else {
                    return false
            }
            return title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
