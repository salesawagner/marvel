//
//  ViewExtensions.swift
//  MarvelTests
//
//  Created by Wagner Sales on 11/12/23.
//

import UIKit

extension UIView {
    var tapGesture: UITapGestureRecognizer? {
        gestureRecognizers?.compactMap { $0 as? UITapGestureRecognizer }.first
    }
}
