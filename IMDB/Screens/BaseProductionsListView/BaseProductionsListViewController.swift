//
//  BaseMoviesLisViewController.swift
//  IMDB
//
//  Created by Аслан Микалаев on 26.05.2023.
//

import UIKit

class BaseProductionsListViewController: UIViewController {
    
    // MARK: - Public
    weak var delegate: Presenter?
    var dataSource: [MostPopularDetail] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    let network = ServiceFactory.shared
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(
            width: (view.frame.size.width - 45) / 2,
            height: (view.frame.size.width - 95)
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            ProductionsBaseCell.self,
            forCellWithReuseIdentifier: ProductionsBaseCell.identifier
        )
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setup()
    }
    
    // MARK: - Networking
    func fetchData() {
        
    }
}

// MARK: - Setup views
extension BaseProductionsListViewController {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
                        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Data source and delegate
extension BaseProductionsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionsBaseCell.identifier, for: indexPath) as! ProductionsBaseCell
        let tvsModel = dataSource[indexPath.item]
        cell.configure(tvsModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.dataSource[indexPath.item]
        delegate?.showDetail(selectedItem)
    }
}
