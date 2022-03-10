//
//  ResultTableCell.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit

class ResultTableCell: UITableViewCell {
    var albumIV: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    var lblTitle: UILabel = {
        let titleLable = UILabel()
        titleLable.font = UIFont.systemFont(ofSize: 15)
        titleLable.translatesAutoresizingMaskIntoConstraints = false

        return titleLable
    }()

    var lblSubTitle: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 10)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        return subTitleLabel
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
        addSubview(albumIV)
        addSubview(lblTitle)
        addSubview(lblSubTitle)

        NSLayoutConstraint.activate([
            albumIV.centerYAnchor.constraint(equalTo: centerYAnchor),
            albumIV.heightAnchor.constraint(equalToConstant: 30.0),
            albumIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            albumIV.widthAnchor.constraint(equalToConstant: 30.0),

            lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            lblTitle.leadingAnchor.constraint(equalTo: albumIV.trailingAnchor, constant: 10),
            lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor),

            lblSubTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5),
            lblSubTitle.leadingAnchor.constraint(equalTo: albumIV.trailingAnchor, constant: 10),
            lblSubTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            lblSubTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }

    func configureCell(index: Int) {
        DispatchQueue.global(qos: .default).async { [weak self] in
            do {
                guard let url = URL(string: "") else { return }
                guard let image = UIImage(data: try Data(contentsOf: url)) else { return }

                DispatchQueue.main.async {
                    self?.albumIV.image = image
                }
                return

            } catch {
                print("error is \(error)")
            }
        }

        lblTitle.text = "Title \(index)"
        lblSubTitle.text = "SubTitle \(index)"
    }
}
