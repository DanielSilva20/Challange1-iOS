//
//  View+ActivityIndicator.swift
//  Challange-1-iOS
//
//  Created by Daniel Silva on 10/12/22.
//

import UIKit

extension UIView {
    static let loadingViewTag = 1938123987
    func showLoading(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.medium) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            let loading = self?.viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
            loading?.stopAnimating()
            loading?.removeFromSuperview()

        }
    }
}
