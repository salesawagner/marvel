//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

final class CharactersViewController: MarvelTableViewController {
    // MARK: Properties

    var viewModel: CharactersInputProtocol

    let searchBar = UISearchBar()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var collapsed = Set<Int>()
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: CharactersInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: CharactersInputProtocol = CharactersViewModel()) -> CharactersViewController {
        let viewController = CharactersViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        setupSearchBar()
        setupRefreshControl()
    }

    override func setupTableView() {
        super.setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.register(CharacterRow.self, forCellReuseIdentifier: CharacterRow.identifier)
    }

    // MARK: Setups

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar..."
        searchBar.backgroundColor = .black
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = nil

        // Modify search bar text color
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = .white
        }
    }

    @objc
    func didRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.requestCharacters(nameStartsWith: searchBar.text)
    }

    @objc
    private func tapSection(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }

        if collapsed.contains(view.tag) {
            collapsed.remove(view.tag)
        } else {
            collapsed.insert(view.tag)
        }

        tableView.reloadSections([view.tag], with: .fade)
    }
}

// MARK: - UISearchBarDelegate

extension CharactersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestCharacters(nameStartsWith: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collapsed.contains(section) ? viewModel.sections[section].rows.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterRow.identifier) as? CharacterRow
        cell?.setup(with: section.rows[indexPath.row])
        cell?.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .gray

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = HeaderView.identifier
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HeaderView else {
            return nil
        }

        view.setup(with: viewModel.sections[section])
        view.tag = section
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSection(_:))))

        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelecteRow(indexPath: indexPath)
    }
}

// MARK: - CharactersOutnputProtocol

extension CharactersViewController: CharactersOutputProtocol {
    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 0
            self?.tableView.alpha = 0
        }
    }

    func success() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.errorView?.alpha = 0
            self?.errorView?.removeFromSuperview()
            self?.errorView = nil
        }
    }

    func failure() {
        activityIndicator.stopAnimating()
        guard errorView == nil else { return }

        errorView = UIView()
        errorView?.backgroundColor = .blue
        errorView?.alpha = 0
        errorView?.fill(on: view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 1
            self?.tableView.alpha = 0
        }
    }
}
