//
//  CategoryTableViewController.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 13/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import UIKit

protocol SearchTableDelegate {
    func didSelectFood(food: Food)
}

class CategoryTableViewController: UITableViewController {

    var categories: [Category] = []
    var dataManager: DataManager!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = try! dataManager.getCategories()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let foodViewController = storyboard.instantiateViewController(withIdentifier: "foodSearchTableViewController") as! FoodSearchTableViewController
        
        foodViewController.dataManager = dataManager
        foodViewController.delegate = self
        
        searchController = UISearchController(searchResultsController: foodViewController)
        searchController.searchResultsUpdater = foodViewController
        searchController.searchBar.tintColor = UIColor(red: 57/255.0, green: 198/255.0, blue: 121/266.0, alpha: 1.0)
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.category
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategory" {
            let foodViewController = segue.destination as! FoodTableViewController
            foodViewController.dataManager = dataManager
            foodViewController.category = categories[tableView.indexPathForSelectedRow!.row]
        }
    }

}

extension CategoryTableViewController: SearchTableDelegate {
    func didSelectFood(food: Food) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let foodViewController = storyboard.instantiateViewController(withIdentifier: "foodViewController") as! FoodViewController
        foodViewController.food = food
        navigationController?.pushViewController(foodViewController, animated: true)
    }
}
