//
//  DetailCell.swift
//  Movies
//
//  Created by msc on 24.05.2021.
//

import UIKit
import  SnapKit

class DetailCell: UICollectionViewCell {
    static let identifier = "detailCell"

    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    func setupCell(model: Movie?) {
        descriptionTextView.text = model?.overview

    }

    private func setupLayout() {
        addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
