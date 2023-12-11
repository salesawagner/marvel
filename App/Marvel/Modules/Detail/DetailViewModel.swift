//
//  DetailViewModel.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import API

class DetailViewModel {
    // MARK: Properties

    private var api: APIClient
    private var response: [GetComicResponse] = []
    private let resourceURI: String?

    let name: String
    var viewController: DetailOutputProtocol?
    var sections: [DetailSectionViewModel] = []

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production), name: String, resourceURI: String) {
        self.api = api
        self.name = name
        self.resourceURI = resourceURI
    }
}

// MARK: - DetailsInputProtocol

extension DetailViewModel: DetailInputProtocol {
    func viewDidLoad() {
        viewController?.setTitle(name)
        requestComic()
    }

    func requestComic() {
        guard let resourceURI = resourceURI else {
            viewController?.failure()
            return
        }
        viewController?.startLoading()
        api.send(GetComicRequest(resourceName: resourceURI)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.sections = response.sectionsViewModel
                self?.viewController?.success()

            case .failure:
                self?.viewController?.failure()
            }
        }
    }
}
