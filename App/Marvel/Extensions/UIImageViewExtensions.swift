//
//  UIImageViewExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

extension UIImageView {
    func setNoImage() {

    }

    func loadFromUrl(url: URL?) {
        guard let url = url else {
            setNoImage()
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
           guard let data = data, error == nil else {
               self?.setNoImage()
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
