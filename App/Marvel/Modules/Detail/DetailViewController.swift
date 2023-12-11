//
//  DetailViewController.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

final class DetailViewController: MarvelTableViewController {
    // MARK: - Properties

    var viewModel: DetailInputProtocol

    let refreshControl: UIRefreshControl = UIRefreshControl()
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: DetailInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: DetailInputProtocol) -> DetailViewController {
        let viewController = DetailViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        setupRefreshControl()
    }

    override func setupTableView() {
        super.setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.addSubview(refreshControl)
    }

    // MARK: Setups

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
    }

    // MARK: Actions

    @objc
    func didRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.requestComic()
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = section.rows[indexPath.row].text
        cell?.textLabel?.numberOfLines = 0
        cell?.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .gray

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewModel = viewModel.sections[section]
        let view = UIView(frame: .zero)

        let thumbnail = UIImageView()
        thumbnail.contentMode = .scaleAspectFit
        thumbnail.loadFromUrl(url: viewModel.thumbnailURL)
        thumbnail.fill(on: view, constant: 8)
        NSLayoutConstraint.activate([thumbnail.heightAnchor.constraint(equalToConstant: 200)])

        return view
    }
}

// MARK: - DetailOutputProtocol

extension DetailViewController: DetailOutputProtocol {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 0
            self?.tableView.alpha = 0
        }
    }

    func success() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.errorView?.alpha = 0
            self?.errorView?.removeFromSuperview()
            self?.errorView = nil
        }
    }

    func failure() {
        tableView.reloadData()
        refreshControl.endRefreshing()
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
