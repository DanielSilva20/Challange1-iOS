import UIKit
import CoreData
import RxSwift

class AvatarPersistence {
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveAvatar(currentAvatar: Avatar) -> Completable {
        return Completable.create { completable in
            let managedContext = self.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "AvatarEntity",
                                         in: managedContext)!
            let avatar = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            avatar.setValue(currentAvatar.login, forKeyPath: "login")
            avatar.setValue(currentAvatar.id, forKey: "id")
            avatar.setValue(currentAvatar.avatarUrl.absoluteString, forKey: "avatarUrl")
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

    func rxFetchAvatarData() -> Single<[Avatar]> {
        return Single<[Avatar]>.create { single in
            let managedContext = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

            guard let fetchedRequest = try? managedContext.fetch(fetchRequest) else {
                single(.failure(PersistenceError.fetchError))
                return Disposables.create()
            }
            let avatars: [Avatar] = fetchedRequest.compactMap { item -> Avatar? in
                item.toAvatar()
            }
            single(.success(avatars))
            return Disposables.create()
        }
    }

    func rxCheckIfItemExist(avatarName: String) -> Observable<Avatar?> {
        return Observable<Avatar?>.create({ observer in
            let managedContext = self.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
            fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", avatarName)

            guard let matchAvatar = try? managedContext.fetch(fetchRequest) else { return Disposables.create() }

            observer.onNext(matchAvatar.first?.toAvatar())

            return Disposables.create()
        })
    }

    func delete(avatar: Avatar) -> Completable {
        return Completable.create { completable in
            let managedContext = self.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
            fetchRequest.predicate = NSPredicate(format: "login = %@", avatar.login)

            do {
                let avatarToDelete = try managedContext.fetch(fetchRequest)
                if avatarToDelete.count == 1 {
                    guard let avatar = avatarToDelete.first else {
                        completable(.error(PersistenceError.deleteError))
                        return Disposables.create {}
                    }
                    managedContext.delete(avatar)
                    try managedContext.save()
                }

            } catch let error as NSError {
                print("Error deleting Avatar: \(error)")
                completable(.error(PersistenceError.deleteError))
                return Disposables.create {}
            }
            completable(.completed)
            return Disposables.create {}
        }
    }

}
