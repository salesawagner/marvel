//
//  HeaderView.swift
//  Marvel
//
//  Created by Wagner Sales on 10/12/23.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {
    static var identifier = String(describing: HeaderView.self)

    // MARK: Properties

    private let nameLabel = UILabel()
    private let thumbnail = UIImageView()

    // MARK: Constructors

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setups

    private func setupUI() {
        backgroundColor = .gray
        setupThumbnail()
        setupStackView()
    }

    private func setupThumbnail() {
        thumbnail.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: 100),
            thumbnail.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8

        stackView.addArrangedSubview(thumbnail)
        stackView.addArrangedSubview(nameLabel)
        stackView.fill(on: self, constant: 8)
    }

    func setup(with viewModel: CharacterSectionViewModel) {
        nameLabel.text = viewModel.name
        thumbnail.loadFromUrl(url: viewModel.thumbnailURL)
    }
}
