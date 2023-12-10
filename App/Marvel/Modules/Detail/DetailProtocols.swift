//
//  DetailProtocols.swift
//  Marvel
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation

protocol DetailInputProtocol {
    var viewController: DetailOutputProtocol? { get set }
    var sections: [DetailSectionViewModel] { get }
    func viewDidLoad()
    func requestComic()
}

protocol DetailOutputProtocol {
    func setTitle(_ title: String)
    func startLoading()
    func success()
    func failure()
}
