//
//  NSManagedObject+Emoji.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/2/22.
//

import UIKit
import CoreData

extension NSManagedObject {
    func toEmoji() -> Emoji? {
        guard let nameItem = self.value(forKey: "name") as? String else { return nil }
        guard let urlAsString = self.value(forKey: "url") as? String else { return nil }
        guard let urlItem = URL(string: urlAsString) else { return nil }
        return Emoji(name: nameItem,
                     emojiUrl: urlItem)

    }
}
