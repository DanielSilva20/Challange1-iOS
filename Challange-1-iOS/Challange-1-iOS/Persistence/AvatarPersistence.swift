import UIKit
import CoreData

class AvatarPersistence {
    var avatarsPersistenceList: [NSManagedObject] = []
    var appDelegate: AppDelegate
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }

    func saveAvatar(currentAvatar: Avatar) {
        
        DispatchQueue.main.async {
            
            // 1
            let managedContext = self.appDelegate.persistentContainer.viewContext
            
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
    
    func fetchAvatarData(_ resulthandler: @escaping ([NSManagedObject]) -> Void) {
        var array: [NSManagedObject]
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        
        //3
        do {
            array = try managedContext.fetch(fetchRequest)
            resulthandler(array)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func checkIfItemExist(login: String, _ resultHandler: @escaping (Result<[NSManagedObject],Error>) -> Void) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", login)
        
        do {
            let matchAvatar = try managedContext.fetch(fetchRequest)
            resultHandler(.success(matchAvatar))
        } catch {
            print(error)
            resultHandler(.failure(error))
        }
    }
    
}

