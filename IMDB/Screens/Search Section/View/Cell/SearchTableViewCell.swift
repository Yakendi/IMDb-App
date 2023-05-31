//
//  MovieSearchTableViewCell.swift
//  IMDB
//
//  Created by Аслан Микалаев on 24.05.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Identiifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    
    // images
    private let productionsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 0.3
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.cornerRadius = 2
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        return image
    }()
    
    private let productionsNameLabel = UILabel()
    private let productionsDescriptionLabel = UILabel()
    
    // MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.productionsImageView.image = nil
    }
    
    // MARK: - Configurator
    func configure(_ model: MovieDetails) {
        
        productionsImageView.kf.indicatorType = .activity
        productionsImageView.kf.setImage(with: URL(string: model.image))
        
        productionsNameLabel.text = model.title
        productionsNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        productionsNameLabel.numberOfLines = 0
        
        productionsDescriptionLabel.text = model.description
        productionsDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        productionsDescriptionLabel.textColor = .systemGray
        productionsDescriptionLabel.numberOfLines = 0
    }
}

// MARK: - Setup views
private extension SearchTableViewCell {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        
        contentView.addSubview(productionsImageView)
        productionsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(100)
            make.width.equalTo(80)
        }
        
        contentView.addSubview(productionsNameLabel)
        productionsNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productionsImageView.snp.trailing).offset(8)
            make.top.equalTo(productionsImageView.snp.top)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(productionsDescriptionLabel)
        productionsDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(productionsNameLabel.snp.leading)
            make.top.equalTo(productionsNameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(productionsNameLabel.snp.trailing)
        }
    }
}
