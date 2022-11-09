//
//  EmojiPersistence.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/11/22.
//

import UIKit
import CoreData

class EmojiPersistence {
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveEmoji(name: String, url: String) {

            // 1
            let managedContext = self.persistentContainer.viewContext

            // 2
            let entity = NSEntityDescription.entity(forEntityName: "EmojiEntity",
                                                    in: managedContext)!

            let emoji = NSManagedObject(entity: entity,
                                        insertInto: managedContext)

            // 3
            emoji.setValue(name, forKeyPath: "name")
            emoji.setValue(url, forKeyPath: "url")

            // 4
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
    }

    func fetchEmojisData() -> [Emoji] {
        var array: [NSManagedObject] = []
        var emojisArray: [Emoji] = []

        let managedContext = persistentContainer.viewContext

        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

        // 3
        do {
            array = try managedContext.fetch(fetchRequest)
            emojisArray = array.compactMap({ item -> Emoji? in
                item.toEmoji()
            })
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return emojisArray
    }
}
