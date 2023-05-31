//
//  TopListViewController.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit
import SnapKit

class TopListViewController: UIViewController {
    
    // MARK: - Public
    weak var delegate: Presenter?
    var topListData: [MostPopularDetail] = []
    let network = ServiceFactory.shared
    
    // MARK: - UI
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Movies", "TVs"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlHandle), for: .valueChanged)
        control.backgroundColor = .secondarySystemBackground
        return control
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CellForTop250.self, forCellReuseIdentifier: CellForTop250.identifier)
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchTopMoviesData()
    }
    
    // MARK: - Segmented control handling
    @objc func segmentedControlHandle() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            fetchTopMoviesData()
        case 1:
            fetchTopTVsData()
        default:
            break
        }
    }
    
    // MARK: - Networking
    func fetchTopMoviesData() {
        self.network.getTopMoviesList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case (.success(let data)):
                self.topListData = data.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (.failure(_)):
                self.showAlert(title: NetworkErrorTypes.emptyData.errorDescription ?? "Error")
            }
        }
    }
    
    func fetchTopTVsData() {
        self.network.getTopTVsList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case (.success(let data)):
                self.topListData = data.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (.failure(_)):
                self.showAlert(title: NetworkErrorTypes.emptyData.errorDescription ?? "Error")
            }
        }
    }
}

// MARK: - Setup views
private extension TopListViewController {
    func setup() {
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Top 250"
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.addArrangedSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        stackView.addArrangedSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Table view data source and delegate
extension TopListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellForTop250.identifier, for: indexPath) as! CellForTop250
        cell.accessoryType = .disclosureIndicator
        let data = topListData[indexPath.row]
        cell.configure(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRow = topListData[indexPath.row]
        delegate?.showDetail(selectedRow)
    }
}
