//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import API

class CharactersViewModel {
    // MARK: Properties

    private var api: APIClient
    private var response: [ComicCharacterResponse] = []

    var viewController: CharactersOutputProtocol?
    var sections: [CharacterSectionViewModel] = []
    var collapsed = Set<Int>()

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production)) {
        self.api = api
    }
}

// MARK: - CharactersInputProtocol

extension CharactersViewModel: CharactersInputProtocol {
    func viewDidLoad() {
        requestCharacters()
    }

    func requestCharacters(nameStartsWith: String? = nil) {
        viewController?.startLoading()
        api.send(GetCharactersRequest(nameStartsWith: nameStartsWith)) { [weak self] result in
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

    func didSelectSection(section: Int) {
        if collapsed.contains(section) {
            collapsed.remove(section)
        } else {
            collapsed.insert(section)
        }

        viewController?.update(section: section)
    }

    func didSelectRow(indexPath: IndexPath) {
        let character = response[indexPath.section]
        let comic = character.comics.items[indexPath.row]

        (viewController as? UIViewController)?.navigationController?.pushViewController(
            DetailViewController.create(with: DetailViewModel(name: comic.name, resourceURI: comic.resourceURI)),
            animated: true
        )
    }
}
