import UIKit
import CoreData

import RxSwift

class AvatarPersistence {
    var avatarsPersistenceList: [NSManagedObject] = []
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveAvatar(currentAvatar: Avatar) {

        DispatchQueue.main.async {

            // 1
            let managedContext = self.persistentContainer.viewContext

            // 2
            let entity = NSEntityDescription.entity(forEntityName: "AvatarEntity",
                                         in: managedContext)!

            let avatar = NSManagedObject(entity: entity,
                                         insertInto: managedContext)

            // 3
            avatar.setValue(currentAvatar.login, forKeyPath: "login")
            avatar.setValue(currentAvatar.id, forKey: "id")
            avatar.setValue(currentAvatar.avatarUrl.absoluteString, forKey: "avatarUrl")

            // 4
            do {
              try managedContext.save()
                self.avatarsPersistenceList.append(avatar)

            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }

    }

//    func fetchAvatarData(_ resulthandler: @escaping ([Avatar]) -> Void) {
//        var array: [NSManagedObject]
//        var avatarArray: [Avatar]
//
//        let managedContext = persistentContainer.viewContext
//
//        // 2
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
//
//        // 3
//        do {
//            array = try managedContext.fetch(fetchRequest)
//            avatarArray = array.compactMap({ item -> Avatar? in
//                item.toAvatar()
//            })
//            resulthandler(avatarArray)
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }

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

//    func checkIfItemExist(login: String, _ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {
//        var avatar: [Avatar]
//
//        let managedContext = persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
//        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", login)
//
//        do {
//            let matchAvatar = try managedContext.fetch(fetchRequest)
//            avatar = matchAvatar.compactMap({ item -> Avatar? in
//                return item.toAvatar()
//            })
//            resultHandler(.success(avatar))
//        } catch {
//            print(error)
//            resultHandler(.failure(error))
//        }
//    }

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

    func delete(avatarObject: Avatar) {

        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
        fetchRequest.predicate = NSPredicate(format: "login = %@", avatarObject.login)

        do {
            let avatarToDelete = try managedContext.fetch(fetchRequest)
            if avatarToDelete.count == 1 {
                guard let avatar = avatarToDelete.first else { return }
                managedContext.delete(avatar)
                try managedContext.save()
            }

        } catch let error as NSError {
            print("Error deleting Avatar: \(error)")
        }
    }

}
