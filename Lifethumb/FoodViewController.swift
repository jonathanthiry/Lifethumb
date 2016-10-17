//
//  FoodViewController.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 14/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import UIKit

class FoodViewController: UITableViewController {
    
    var food: Food!

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var saturatedFatLabel: UILabel!
    @IBOutlet weak var unsaturatedFatLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodLabel.text = food.title
        proteinLabel.text = String(format: "%.1fg", food.protein)
        fatLabel.text = String(format: "%.1fg", food.fat)
        saturatedFatLabel.text = String(format: "%.1fg", food.saturatedfat)
        unsaturatedFatLabel.text = String(format: "%.1fg", food.unsaturatedfat)
        carbsLabel.text = String(format: "%.1fg", food.carbohydrates)
        fiberLabel.text = String(format: "%.1fg", food.fiber)
        sugarLabel.text = String(format: "%.1fg", food.sugar)
        
        // TODO: Create a UILabel subclass to change the font
        proteinLabel.font = UIFont.monospacedDigitSystemFont(ofSize: proteinLabel.font.pointSize, weight: UIFontWeightBold)
        fatLabel.font = UIFont.monospacedDigitSystemFont(ofSize: fatLabel.font.pointSize, weight: UIFontWeightBold)
        saturatedFatLabel.font = UIFont.monospacedDigitSystemFont(ofSize: saturatedFatLabel.font.pointSize, weight: UIFontWeightRegular)
        unsaturatedFatLabel.font = UIFont.monospacedDigitSystemFont(ofSize: unsaturatedFatLabel.font.pointSize, weight: UIFontWeightRegular)
        carbsLabel.font = UIFont.monospacedDigitSystemFont(ofSize: carbsLabel.font.pointSize, weight: UIFontWeightBold)
        fiberLabel.font = UIFont.monospacedDigitSystemFont(ofSize: fiberLabel.font.pointSize, weight: UIFontWeightRegular)
        sugarLabel.font = UIFont.monospacedDigitSystemFont(ofSize: sugarLabel.font.pointSize, weight: UIFontWeightRegular)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        return footerView
    }

}
