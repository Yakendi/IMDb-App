//
//  MoviesListCollectionViewCell.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class ProductionsBaseCell: UICollectionViewCell {
    
    // MARK: - Identiifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    // images
    private let productionsImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 4
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        return image
    }()
    
    private let ratingStarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // labels
    private let productionsNameLabel = UILabel()
    private let productionsYearLabel = UILabel()
    private let productionsRatingLabel = UILabel()
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    func configure(_ model: MostPopularDetail) {
        
        productionsImageView.kf.indicatorType = .activity
        productionsImageView.kf.setImage(with: URL(string: model.image))
        
        productionsNameLabel.text = model.title
        productionsNameLabel.numberOfLines = 2
        
        productionsYearLabel.text = "(\(model.year))"
        productionsYearLabel.textColor = .systemGray
        
        productionsRatingLabel.text = model.imDbRating
        productionsRatingLabel.textColor = .systemGray
        
        [productionsNameLabel, productionsYearLabel, productionsRatingLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    
}

// MARK: - Setup views
private extension ProductionsBaseCell {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        
        contentView.addSubview(productionsImageView)
        productionsImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.74)
        }
        
        contentView.addSubview(productionsNameLabel)
        productionsNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalTo(productionsImageView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        contentView.addSubview(productionsYearLabel)
        productionsYearLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalTo(productionsNameLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(ratingStarImageView)
        ratingStarImageView.snp.makeConstraints { make in
            make.leading.equalTo(productionsYearLabel.snp.trailing).offset(8)
            make.top.equalTo(productionsNameLabel.snp.bottom).offset(4)
            make.height.width.equalTo(20)
        }
        
        contentView.addSubview(productionsRatingLabel)
        productionsRatingLabel.snp.makeConstraints { make in
            make.leading.equalTo(ratingStarImageView.snp.trailing).offset(5)
            make.bottom.equalTo(ratingStarImageView.snp.bottom)
        }
    }
}
