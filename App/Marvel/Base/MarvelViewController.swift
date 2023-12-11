//
//  MarvelViewController.swift
//  Marvel
//
//  Created by Wagner Sales on 10/12/23.
//

import UIKit

class MarvelTableViewController: UIViewController {
    // MARK: Properties
    let activityIndicator = UIActivityIndicatorView()
    let tableView = UITableView(frame: .zero, style: .grouped)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Setups

    func setupUI() {
        view.backgroundColor = .white
        setupActivityIndicator()
        setupTableView()
    }

    func setupActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkText
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 8
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.fill(on: view)
    }
}
