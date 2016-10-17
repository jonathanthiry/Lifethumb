//
//  DataManager.swift
//  Lifethumb
//
//  Created by Jonathan Thiry on 12/10/16.
//  Copyright © 2016 Jonathan Thiry. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    var language: String
    var languages = ["en_US", "en_GB", "da_DK", "it_IT", "fr_FR", "es_ES", "sv_SE", "de_DE"]
    
    init?() {
        if let userLanguage = UserDefaults.standard.object(forKey: "language") as? String {
            language = userLanguage
        } else {
            if languages.contains(Locale.current.identifier) {
                language = Locale.current.identifier
            } else {
                language = "en_US"
            }
            UserDefaults.standard.set(language, forKey: "language")
        }
        
        if UserDefaults.standard.bool(forKey: "dataImported") == false {
            do {
                try loadDataFromJSON()
            } catch {
                return nil
            }
        }
    }
    
    func getCategories() throws -> [Category] {
        var categories: [Category]
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "headcategoryid != %d", 15)
        
        do {
            categories = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            throw LoadingError.Fetch
        }
        
        return categories
    }
    
    func getExercises() throws -> [Exercise] {
        var exercises: [Exercise]
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            exercises = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            throw LoadingError.Fetch
        }
        
        return exercises
    }
    
    func getFoods(forCategory category: Category? = nil) throws -> [Food] {
        var foods: [Food]
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let category = category {
            fetchRequest.predicate = NSPredicate(format: "language == %@ AND ocategoryid == %d", language, category.oid)
        } else {
            fetchRequest.predicate = NSPredicate(format: "language == %@", language)
        }
        
        do {
            foods = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            throw LoadingError.Fetch
        }
        
        return foods
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Lifethumb")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    enum LoadingError: Error {
        case FileNotFound
        case Fetch
    }
    
    func loadDataFromJSON() throws {
        guard let categoriesFileURL = Bundle.main.url(forResource: "categoriesStatic", withExtension: "json"),
            let exercisesFileURL = Bundle.main.url(forResource: "exercisesStatic", withExtension: "json"),
            let foodFileURL = Bundle.main.url(forResource: "foodStatic", withExtension: "json")
        else {
            throw LoadingError.FileNotFound
        }
        
        do {
            let categoriesData = try Data(contentsOf: categoriesFileURL, options: .mappedIfSafe)
            let exercisesData = try Data(contentsOf: exercisesFileURL, options: .mappedIfSafe)
            let foodsData = try Data(contentsOf: foodFileURL, options: .mappedIfSafe)
            
            let categories = try JSONSerialization.jsonObject(with: categoriesData, options: []) as! [[String : Any]]
            let exercises = try JSONSerialization.jsonObject(with: exercisesData, options: []) as! [[String : Any]]
            let foods = try JSONSerialization.jsonObject(with: foodsData, options: []) as! [[String : Any]]
            
            for categoryDictionary in categories {
                let category = Category(context: persistentContainer.viewContext)
                category.category = categoryDictionary["category"] as? String
                category.headcategoryid = Int64(categoryDictionary["headcategoryid"] as! Double)
                category.oid = Int64(categoryDictionary["oid"] as! Double)
                persistentContainer.viewContext.insert(category)
            }
            
            for exerciseDictionary in exercises {
                let exercise = Exercise(context: persistentContainer.viewContext)
                exercise.oid = Int64(exerciseDictionary["oid"] as! Double)
                exercise.title = exerciseDictionary["title"] as? String
                exercise.calories = exerciseDictionary["calories"] as! Double
                persistentContainer.viewContext.insert(exercise)
            }
            
            for foodDictionary in foods {
                let food = Food(context: persistentContainer.viewContext)
                food.setValuesForKeys(foodDictionary)
                persistentContainer.viewContext.insert(food)
            }
            
            saveContext()
            UserDefaults.standard.set(true, forKey: "dataImported")
        } catch {
            
        }
    }
}
