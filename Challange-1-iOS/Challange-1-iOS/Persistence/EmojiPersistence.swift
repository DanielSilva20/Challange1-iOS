import UIKit
import CoreData
import RxSwift

class EmojiPersistence {
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func save(emoji: Emoji) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(PersistenceError.selfError))
                return Disposables.create {}
            }
            let managedContext = self.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "EmojiEntity",
                                                    in: managedContext)!
            let savedEmoji = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            savedEmoji.setValue(emoji.name, forKeyPath: "name")
            savedEmoji.setValue(emoji.emojiUrl.absoluteString, forKeyPath: "url")
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
