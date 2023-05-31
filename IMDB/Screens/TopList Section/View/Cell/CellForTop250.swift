//
//  CellForTop250.swift
//  IMDB
//
//  Created by Аслан Микалаев on 22.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CellForTop250: UITableViewCell {
    
    // MARK: - Identiifier
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - UI
    
    // images
    private let productionsImageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 0.3
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.cornerRadius = 2
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
    private let productionsRankLabel = UILabel()
    private let productionsNameLabel = UILabel()
    private let productionsYearLabel = UILabel()
    private let productionsRatingLabel = UILabel()
    
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
    func configure(_ model: MostPopularDetail) {
        
        productionsImageView.kf.indicatorType = .activity
        productionsImageView.kf.setImage(with: URL(string: model.image))
        
        productionsRankLabel.text = model.rank
        productionsRankLabel.textColor = .systemGray
        
        productionsNameLabel.text = model.title
        productionsNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        productionsNameLabel.numberOfLines = 0
        
        productionsYearLabel.text = "(\(model.year))"
        productionsYearLabel.textColor = .systemGray
        
        productionsRatingLabel.text = model.imDbRating
        productionsRatingLabel.textColor = .systemGray
        
        [productionsYearLabel, productionsRankLabel, productionsRatingLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
}

// MARK: - Setup views
private extension CellForTop250 {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        
        contentView.addSubview(productionsRankLabel)
        productionsRankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(productionsImageView)
        productionsImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(100)
            make.width.equalTo(80)
        }
        
        contentView.addSubview(productionsNameLabel)
        productionsNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productionsImageView.snp.trailing).offset(8)
            make.top.equalTo(productionsImageView.snp.top)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(productionsYearLabel)
        productionsYearLabel.snp.makeConstraints { make in
            make.leading.equalTo(productionsImageView.snp.trailing).offset(8)
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
