//
//  MainMovieCell.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import UIKit
import SnapKit
class MainMovieCell: UITableViewCell {
static let identifier = "movieCell"

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    lazy var raitingLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        createTitleStack()
        backgroundColor = .black
        selectionStyle = .none

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(model: Movie) {
        guard  let url = model.imagePosterUrl else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        posterImageView.image = UIImage(data: data)
        titleLabel.text = model.title
        raitingLabel.text = String(model.voteAverage)

    }

    func createTitleStack() {
        let stack = createRaitingStack(label: raitingLabel)
        let headerStack = UIStackView(arrangedSubviews: [titleLabel, stack])
        headerStack.axis = .vertical
        headerStack.alignment = .leading
        headerStack.spacing = 8
        addSubview(headerStack)
        headerStack.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.top.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupLayout() {
        addSubview(posterImageView)

        posterImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(90)
        }

    }

}
