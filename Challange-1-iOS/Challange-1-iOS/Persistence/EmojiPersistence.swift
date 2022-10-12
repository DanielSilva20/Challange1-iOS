//
//  EmojiPersistence.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/11/22.
//

import UIKit
import CoreData

class EmojiPersistence {
    var emojisPersistenceList: [NSManagedObject] = []

    func saveEmoji(name: String, url: String) {
        
        DispatchQueue.main.async {
            guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
              return
            }
            
            // 1
            let managedContext =
              appDelegate.persistentContainer.viewContext
            
            // 2
            let entity =
              NSEntityDescription.entity(forEntityName: "EmojiEntity",
                                         in: managedContext)!
            
            let emoji = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            
            // 3
              emoji.setValue(name, forKeyPath: "name")
              emoji.setValue(url, forKey: "url")
            
            // 4
            do {
              try managedContext.save()
                self.emojisPersistenceList.append(emoji)
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
      
      
    }
    
    func loadData() -> [NSManagedObject] {
        var array: [NSManagedObject] = []
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return array
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")
        
        //3
        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return array
    }
}

