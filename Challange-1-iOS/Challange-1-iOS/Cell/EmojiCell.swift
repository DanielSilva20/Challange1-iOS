//
//  EmojiCell.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/25/22.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    
    let imageView: UIImageView
    var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        imageView = .init(frame: .zero)
        super.init(frame: .zero)
        self.contentView.addSubview(imageView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpCell(url: URL) {
        imageView.downloaded(from: url)
    }
    
    func setUpConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     imageView.topAnchor.constraint(equalTo: self.topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        
        imageView.image = nil
    }
    
}


