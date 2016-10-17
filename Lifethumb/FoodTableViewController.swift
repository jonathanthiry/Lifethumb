//
//  FoodTableViewController.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 13/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    var foods: [Food] = []
    var category: Category?
    var dataManager: DataManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods = try! dataManager.getFoods(forCategory: category)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let food = foods[indexPath.row]

        cell.textLabel?.text = food.title

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFood" {
            let foodViewController = segue.destination as! FoodViewController
            foodViewController.food = foods[tableView.indexPathForSelectedRow!.row]
        }
    }

}
