//
//  NoResultTableCell.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit

class NoResultTableCell: UITableViewCell {
    private let noResultLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 24)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(noResultLabel)

        NSLayoutConstraint.activate([
            noResultLabel.topAnchor.constraint(equalTo: topAnchor),
            noResultLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            noResultLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    func configureCell(text: String) {
        noResultLabel.text = text
    }
}
