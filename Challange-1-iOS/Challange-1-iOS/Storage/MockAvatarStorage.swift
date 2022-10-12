
import UIKit

class MockAvatarStorage: AvatarService {
    
    private var mockedAvatars: MockedAvatarStorage = .init()
    
    var avatars: [Avatar] = []
    
    func getAvatarList(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {
        avatars = mockedAvatars.avatars
        resultHandler(.success(avatars))
    }

}
