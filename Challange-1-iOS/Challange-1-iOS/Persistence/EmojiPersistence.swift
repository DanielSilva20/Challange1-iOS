import UIKit
import CoreData
import RxSwift

enum PersistenceError: Error {
    case fetchError
    case saveError
    case deleteError
}

class EmojiPersistence {
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveEmoji(name: String, url: String) -> Completable {
        return Completable.create { completable in
            let managedContext = self.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "EmojiEntity",
                                                    in: managedContext)!
            let emoji = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            emoji.setValue(name, forKeyPath: "name")
            emoji.setValue(url, forKeyPath: "url")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completable(.error(PersistenceError.saveError))
                return Disposables.create {}
            }
            completable(.completed)
            return Disposables.create {}
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

    func rxFetchEmojisData() -> Single<[Emoji]> {
        return Single<[Emoji]>.create { single in

            let managedContext = self.persistentContainer.viewContext

            // 2
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

            guard
                let resultFetch = try? managedContext.fetch(fetchRequest)
            else {
                single(.failure(PersistenceError.fetchError))
                return Disposables.create {}
            }
            let result: [Emoji] = resultFetch.compactMap({ item -> Emoji? in
                item.toEmoji()
            })
            single(.success(result))
            return Disposables.create {  }
        }
    }
}
