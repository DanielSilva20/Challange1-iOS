import UIKit
import CoreData

extension NSManagedObject {
    func toAvatar() -> Avatar? {
        guard let loginItem = self.value(forKey: "login") as? String else { return nil }
        guard let idItem = self.value(forKey: "id") as? Int else { return nil }
        guard let urlString = self.value(forKey: "avatarUrl") as? String else { return nil }
        guard let avatarUrlItem = URL(string: urlString) as? URL else { return nil }
        return Avatar(
            login: loginItem,
            id: idItem,
            avatarUrl: avatarUrlItem)
    }
}
