//
//  DetailViewController.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

class DetailViewController: UIViewController {

    let viewModel: DetailViewModel
    let activityIndicator = UIActivityIndicatorView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    var errorView: UIView?

    private init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: DetailViewModel) -> DetailViewController {
        let viewController = DetailViewController(viewModel: viewModel)
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

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.fill(on: view)
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

// MARK: - ViewModel Response

extension DetailViewController {
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
