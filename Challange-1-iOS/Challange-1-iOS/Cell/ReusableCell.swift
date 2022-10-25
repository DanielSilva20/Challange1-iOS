//
//  ReusableCell.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/25/22.
//

import Foundation

protocol ReusableView {
    static var reuseCellIdentifier : String { get }
}

extension ReusableView {
    static var reuseCellIdentifier: String {
        //Make the reuseIdentifier the class name
        return String(describing: self)
    }
}
