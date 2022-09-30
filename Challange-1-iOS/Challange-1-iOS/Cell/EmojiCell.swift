//
//  ColorCell.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 9/28/22.
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
        downloadImage(from: url)
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
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        dataTask?.cancel()
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        dataTask?.resume()
    }

    func downloadImage(from url: URL){
        getData(from: url) { [weak self] data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    self?.imageView.image = nil
                    self?.dataTask = nil
                }
                return
            }
            DispatchQueue.main.async() { () in
                self?.imageView.image = nil
                self?.dataTask = nil
                guard let data = data, error == nil else { return }
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    
}


