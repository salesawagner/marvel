//
//  CharacterRow.swift
//  Marvel
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

class CharacterRow: UITableViewCell {
    static var identifier = String(describing: CharacterRow.self)

    // MARK: Properties

    private var nameLabel = UILabel()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupUI() {
        nameLabel.numberOfLines = 0
        nameLabel.fill(on: contentView, constant: 8)
        accessoryType = .disclosureIndicator
    }

    // MARK: Internal Methods

    func setup(with viewModel: CharacterRowViewModel) {
        nameLabel.text = viewModel.name
    }
}
