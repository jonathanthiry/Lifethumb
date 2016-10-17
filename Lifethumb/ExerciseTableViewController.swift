//
//  ExerciseTableViewController.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 12/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import UIKit

class ExerciseTableViewController: UITableViewController {
    
    var exercises: [Exercise] = []
    var dataManager: DataManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercises = try! dataManager.getExercises()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        let exercise = exercises[indexPath.row]

        cell.textLabel?.text = exercise.title
        cell.detailTextLabel?.text = "\(exercise.calories) calories"

        return cell
    }

}
