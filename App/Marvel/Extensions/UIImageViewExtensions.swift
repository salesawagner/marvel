//
//  UIImageViewExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

extension UIImageView {
    func loadFromUrl(url: URL?) {
        guard let url = url else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
           guard let data = data, error == nil else {
               return
           }

           if let downloadedImage = UIImage(data: data) {
               DispatchQueue.main.async {
                   self?.image = downloadedImage
               }
           }
        }

        task.resume()
    }
}
