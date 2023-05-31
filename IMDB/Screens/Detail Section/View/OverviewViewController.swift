//
//  DetailViewController.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import UIKit
import SnapKit

final class OverviewViewController: UIViewController {
    
    // MARK: - UI
    // images
    private let productionsPoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 20
        image.layer.borderWidth = 0.1
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.backgroundColor = .systemGray3
        image.clipsToBounds = true
        return image
    }()
    
    private let ratingStar: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemOrange
        return image
    }()
    
    // stacks
    private let productionsDetailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    private let productionsRatingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    // shadow
    private let shadowView: UIView = {
        let view = UIView()
        return view
    }()
    
    // labels
    private let overviewLabel = UILabel()
    private let productionsNameLabel = UILabel()
    private let productionsRatingLabel = UILabel()
    private let productionsYearLabel = UILabel()
    private let productionDurationLabel = UILabel()
    private let productionsGenreLabel = UILabel()
    
    // separators
    private let firstSeparator = UIView()
    private let secondSeparator = UIView()
    private let thirdSeparator = UIView()
    
    // button
    private let startWatchingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemRed
        button.setTitle("Start watching", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setLayer()
    }
    
    // MARK: - Configurator
    func configure(_ viewModel: MostPopularDetail) {
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        
        productionsPoster.kf.indicatorType = .activity
        productionsPoster.kf.setImage(with: URL(string: viewModel.image))
        
        productionsNameLabel.text = viewModel.title
        productionsNameLabel.textAlignment = .center
        productionsNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        productionsNameLabel.numberOfLines = 0
        
        productionsYearLabel.text = viewModel.year
        productionsRatingLabel.text = viewModel.imDbRating
        productionsGenreLabel.text = "Action"
        productionDurationLabel.text = "2h 35m"
        
        [productionsRatingLabel, productionsYearLabel, productionsGenreLabel, productionDurationLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        }
    }
    
    // MARK: - Setup layers
    func setLayer() {
        
        // shadow
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 10)
        shadowView.layer.shadowRadius = 20
        shadowView.layer.shadowColor = UIColor.systemRed.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.masksToBounds = false
        
        // separators
        [firstSeparator, secondSeparator, thirdSeparator].forEach {
            $0.layer.masksToBounds = false
            $0.layer.cornerRadius = $0.frame.size.width / 2
            $0.backgroundColor = .systemGray
            $0.clipsToBounds = true
        }
    }
}

// MARK: - Setup views
private extension OverviewViewController {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
        }
        view.addSubview(shadowView)
        view.addSubview(productionsPoster)
        shadowView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(productionsPoster.snp.bottom).offset(-30)
            make.height.equalTo(20)
            make.width.equalTo(productionsPoster.snp.width).offset(-80)
        }
        
        productionsPoster.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(overviewLabel.snp.bottom).offset(25)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalToSuperview().multipliedBy(0.57)
        }
        
        view.addSubview(productionsNameLabel)
        productionsNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productionsPoster.snp.leading)
            make.top.equalTo(shadowView.snp.bottom).offset(45)
            make.trailing.equalTo(productionsPoster.snp.trailing)
        }
        
        view.addSubview(startWatchingButton)
        startWatchingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(65)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
        }
        
        setupStackView()
    }
    
    // set stack views constraints
    func setupStackView() {
        // parent stack
        view.addSubview(productionsDetailStack)
        productionsDetailStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(productionsNameLabel.snp.bottom).offset(20)
        }
        productionsDetailStack.addArrangedSubview(productionsRatingStack)
        
        // rating stack
        productionsRatingStack.addArrangedSubview(ratingStar)
        ratingStar.snp.makeConstraints { make in
            make.width.height.equalTo(22)
        }
        productionsRatingStack.addArrangedSubview(productionsRatingLabel)
            
        productionsDetailStack.addArrangedSubview(firstSeparator)
        firstSeparator.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        
        productionsDetailStack.addArrangedSubview(productionsYearLabel)
        
        productionsDetailStack.addArrangedSubview(secondSeparator)
        secondSeparator.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        productionsDetailStack.addArrangedSubview(productionsGenreLabel)
        
        productionsDetailStack.addArrangedSubview(thirdSeparator)
        thirdSeparator.snp.makeConstraints { make in
            make.height.width.equalTo(8)
        }
        
        productionsDetailStack.addArrangedSubview(productionDurationLabel)
        
        [firstSeparator, secondSeparator, thirdSeparator].forEach {
            $0.layoutIfNeeded()
        }
    }
}
