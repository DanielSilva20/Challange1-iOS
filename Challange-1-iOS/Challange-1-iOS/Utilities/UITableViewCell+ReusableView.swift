//
//  UITableViewCell+ReusableView.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/25/22.
//

import Foundation
import UIKit

extension UITableViewCell: ReusableView {}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {

        guard let cell = dequeueReusableCell(withIdentifier: T.reuseCellIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }
}
