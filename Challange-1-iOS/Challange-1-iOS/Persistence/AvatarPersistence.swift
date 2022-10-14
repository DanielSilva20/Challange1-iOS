import UIKit
import CoreData

class AvatarPersistence {
    var avatarsPersistenceList: [NSManagedObject] = []
    
    struct AvatarData: Codable {
        let login: String
        let id: Int
        let avatar_url: String
    }

    func saveAvatar(login: String, id: Int64, avatarUrl: String) {
        
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
              NSEntityDescription.entity(forEntityName: "AvatarEntity",
                                         in: managedContext)!
            
            let avatar = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            
            // 3
              avatar.setValue(login, forKeyPath: "login")
              avatar.setValue(id, forKey: "id")
              avatar.setValue(avatarUrl, forKey: "avatarUrl")
            
            // 4
            do {
              try managedContext.save()
                self.avatarsPersistenceList.append(avatar)
                
                
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
      
      
    }
    
    func fetchAvatarData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        
        //3
        do {
            avatarsPersistenceList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func checkIfItemExist(login: String) -> Bool {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return false
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "AvatarEntity")
        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", login)
        
        do {
            let matchAvatar = try managedContext.fetch(fetchRequest)
            if matchAvatar.isEmpty {
                return false
            }
        } catch {
            print(error)
        }
        return true
    }
}

