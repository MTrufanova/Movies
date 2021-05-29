//
//  HeaderView.swift
//  Movies
//
//  Created by msc on 24.05.2021.
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
    
    static let identifier = "headerViewIdentifier"
    let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .redraw
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    
    lazy var raitingLabel = UILabel()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setupLayout()
        setupGradientLayer()
        createStack()
    }
    
    func createStack()  {
        let stack = createRaitingStack(label: raitingLabel)
        let headerStack = UIStackView(arrangedSubviews: [titleLabel, stack, dateLabel])
        headerStack.axis = .vertical
        headerStack.alignment = .leading
        headerStack.spacing = 8
        addSubview(headerStack)
        headerStack.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.equalToSuperview().inset(16)
        }
        
    }
    
    func setupCell(model: Movie?) {
        guard  let url = model?.imagePosterUrl else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        posterImageView.image = UIImage(data: data)
        titleLabel.text = model?.title
        raitingLabel.text = String(model?.voteAverage ?? 0)
        dateLabel.text = model?.yearOfRelease
    }
    private func setupLayout() {
        addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
        }
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
