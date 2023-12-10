//
//  UIViewExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

extension UIView {
    func fill(on view: UIView, constant: CGFloat = 0) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        ])
    }
}
