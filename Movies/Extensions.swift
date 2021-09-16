//
//  Extensions.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import UIKit

func createRaitingStack(label: UILabel) -> UIStackView {

    label.font = .systemFont(ofSize: 16)
    label.textColor = .white

    let starImageView = UIImageView()
    starImageView.image = UIImage(named: "star")

    let stackView = UIStackView(arrangedSubviews: [starImageView, label])
    stackView.axis = .horizontal
    stackView.spacing = 8

    stackView.frame.size = CGSize(width: starImageView.frame.width + label.frame.width, height: starImageView.frame.height)
    return stackView
}
