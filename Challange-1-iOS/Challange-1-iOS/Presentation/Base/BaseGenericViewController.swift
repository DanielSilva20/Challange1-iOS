//
//  BaseGenericViewController.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/4/22.
//

import Foundation
import UIKit
//
import RxSwift

class BaseGenericViewController<View: BaseGenericView>: UIViewController {

    var disposeBag = DisposeBag()

    var genericView: View {
        // swiftlint:disable:next force_cast
        view as! View
    }

    override func loadView() {
        view = View()
    }
}
