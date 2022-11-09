//
//  Observable+Optional.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/8/22.
//

import Foundation
import UIKit

import RxSwift

extension Observable {
    // swiftlint:disable:next syntactic_sugar
    typealias OptionalElement = Optional<Element>
    func asOptional() -> Observable<OptionalElement> {
        return map({ element -> OptionalElement in return element })
    }
}
