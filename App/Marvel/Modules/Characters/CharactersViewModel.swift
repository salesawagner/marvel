//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import API

class CharactersViewModel {
    // MARK: Properties

    private var api: WASAPI
    private var response: [ComicCharacterResponse] = []

    var viewController: CharactersOutputProtocol?
    var sections: [CharacterSectionViewModel] = []

    // MARK: Inits

    init(api: WASAPI = WASAPI(environment: Environment.production)) {
        self.api = api
    }
}

// MARK: - CharactersInputProtocol

extension CharactersViewModel: CharactersInputProtocol {
    func viewDidLoad() {
        requestCharacters()
    }

    func requestCharacters(name: String? = nil) {
        viewController?.startLoading()
        api.send(GetCharactersRequest(nameStartsWith: name)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.sections = response.sectionViewModel
                self?.viewController?.success()

            case .failure:
                self?.viewController?.failure()
            }
        }
    }

    func didSelecteRow(indexPath: IndexPath) {
        let character = response[indexPath.section]
        let comic = character.comics.items[indexPath.row]

        (viewController as? UIViewController)?.navigationController?.pushViewController(
            DetailViewController.create(with: .init(name: comic.name, resourceURI: comic.resourceURI)),
            animated: true
        )
    }
}
