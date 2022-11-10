import UIKit

public protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }

    func start()
}
