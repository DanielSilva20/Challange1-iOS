//
//  AppleReposCell.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/25/22.
//

import Foundation
import UIKit

class AppleReposCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
