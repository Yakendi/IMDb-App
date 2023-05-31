//
//  SearchViewController.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - Public
    var keyWord = String()
    var searchingData: [MovieDetails] = []
    let network = ServiceFactory.shared
    
    // MARK: - UI
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    
    private let tableViewBackgroundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private let tableViewBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    private let tableViewBacgroundTextLabel: UILabel = {
        let label = UILabel()
        label.text = "What would you like to find?"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .systemGray3
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        return spinner
    }()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Networking
    func fetchSearchingData(keyWord: String) {
        self.network.getSearchingList(with: keyWord) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case (.success(let data)):
                self.searchingData = data.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                }
            case (.failure(_)):
                showAlert(title: NetworkErrorTypes.emptyData.errorDescription ?? "Error")
            }
        }
    }
}

// MARK: - Setup views
private extension SearchViewController {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.addSubview(spinner)
            spinner.center = CGPoint(x: navigationBar.bounds.minX + 152, y: navigationBar.bounds.midY + 22)
        }
        
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.backgroundView = tableViewBackgroundStackView
        tableViewBackgroundStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        tableViewBackgroundStackView.addArrangedSubview(tableViewBackgroundImageView)
        tableViewBackgroundImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        tableViewBackgroundStackView.addArrangedSubview(tableViewBacgroundTextLabel)
    }
}

// MARK: - Search bar delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        UIView.animate(withDuration: 0.4, delay: 0.2) {
            searchBar.showsCancelButton = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.4, delay: 0.2) {
            searchBar.showsCancelButton = false
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyWord = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetchSearchingData(keyWord: self.keyWord)
        self.spinner.startAnimating()
    }
}

// MARK: - Table view data source and delegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let selectedRow = searchingData[indexPath.row]
        cell.configure(selectedRow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
