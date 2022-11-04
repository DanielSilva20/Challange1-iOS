//
//  BaseGenericView.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 11/4/22.
//

import Foundation
import UIKit
//
import RxSwift

class BaseGenericView: UIView {

    var disposeBag = DisposeBag()

    required init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }

    func setupView() {}
}
