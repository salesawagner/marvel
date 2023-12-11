//
//  CharactersProtocols.swift
//  Marvel
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation

protocol CharactersInputProtocol {
    var viewController: CharactersOutputProtocol? { get set }
    var sections: [CharacterSectionViewModel] { get }
    func viewDidLoad()
    func requestCharacters(nameStartsWith: String?)
    func didSelecteRow(indexPath: IndexPath)
}

protocol CharactersOutputProtocol {
    func startLoading()
    func success()
    func failure()
}
