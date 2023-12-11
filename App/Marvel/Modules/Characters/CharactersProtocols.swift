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
    var collapsed: Set<Int> { get }
    func viewDidLoad()
    func requestCharacters(nameStartsWith: String?)
    func didSelectSection(section: Int)
    func didSelectRow(indexPath: IndexPath)
}

protocol CharactersOutputProtocol {
    func startLoading()
    func success()
    func failure()
    func update(section: Int)
}
