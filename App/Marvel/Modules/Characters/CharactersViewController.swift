//
//  CharactersViewController.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

final class CharactersViewController: UIViewController {
    // MARK: Properties

    let viewModel: CharactersViewModel
    let activityIndicator = UIActivityIndicatorView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let searchBar = UISearchBar()
    var collapsed = Set<Int>()
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: CharactersViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: CharactersViewModel) -> CharactersViewController {
        let viewController = CharactersViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }

    // MARK: Setups

    private func setupUI() {
        view.backgroundColor = .white
        setupActivityIndicator()
        setupSearchBar()
        setupTableView()
    }

    private func setupActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkText
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar..."
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = nil
    }

    private func setupTableView() {
        tableView.alpha = 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 8
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(CharacterRow.self, forCellReuseIdentifier: CharacterRow.identifier)
        tableView.fill(on: view)
    }

    @objc
    private func tapSection(sender: UIButton) {
        defer {
            tableView.reloadSections([sender.tag], with: .fade)
        }

        guard !collapsed.contains(sender.tag) else {
            collapsed.remove(sender.tag)
            return
        }

        collapsed.insert(sender.tag)
    }
}

// MARK: - UISearchBarDelegate

extension CharactersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestCharacters(name: searchBar.text)
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
        cell?.setup(viewModel: section.rows[indexPath.row])
        cell?.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .gray

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewModel = viewModel.sections[section]
        let nameLabel = UILabel()
        nameLabel.text = viewModel.name

        let thumbnail = UIImageView()
        thumbnail.loadFromUrl(url: viewModel.thumbnailURL)
        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: 100),
            thumbnail.heightAnchor.constraint(equalToConstant: 100)
        ])

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8

        stackView.addArrangedSubview(thumbnail)
        stackView.addArrangedSubview(nameLabel)

        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        stackView.fill(on: view, constant: 8)

        let button = UIButton(type: .custom)
        button.frame = view.bounds
        button.tag = section
        button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
        
        button.fill(on: view)

        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelecteRow(indexPath: indexPath)
    }
}

// MARK: - ViewModel Response

extension CharactersViewController {
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
