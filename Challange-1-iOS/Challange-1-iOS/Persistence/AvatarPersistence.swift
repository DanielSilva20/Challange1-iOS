import UIKit
import CoreData

class AvatarPersistence {
    var avatarsPersistenceList: [NSManagedObject] = []

    func saveAvatar(login: String, id: Int32, avatarUrl: String) {
        
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
            
            print("number of avatars inside avatar persistence \(self.avatarsPersistenceList)")
            
            // 4
            do {
              try managedContext.save()
                self.avatarsPersistenceList.append(avatar)
                
                
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
          NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        
        //3
        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return array
    }
}

