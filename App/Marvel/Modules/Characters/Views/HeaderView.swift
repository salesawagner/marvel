//
//  HeaderView.swift
//  Marvel
//
//  Created by Wagner Sales on 10/12/23.
//

import UIKit

final class HeaderView: UIView {
    // MARK: Properties

    private let viewModel: CharacterSectionViewModel
    private let nameLabel = UILabel()
    private let thumbnail = UIImageView()

    // MARK: Constructors

    init(viewModel: CharacterSectionViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setups

    func setupUI() {
        backgroundColor = .gray
        setupNameLabel()
        setupThumbnail()
        setupStackView()
    }

    func setupNameLabel() {
        let nameLabel = UILabel()
        nameLabel.text = viewModel.name
    }

    func setupThumbnail() {
        let thumbnail = UIImageView()
        thumbnail.backgroundColor = .lightGray
        thumbnail.loadFromUrl(url: viewModel.thumbnailURL)
        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: 100),
            thumbnail.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8
        
        stackView.addArrangedSubview(thumbnail)
        stackView.addArrangedSubview(nameLabel)
        stackView.fill(on: self, constant: 8)
    }
}
