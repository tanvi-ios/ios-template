//
//  HomeVC.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit

class HomeVC: UIViewController {
    var showDetail: ((SongModel) -> Void)?
    let homeVM: HomeVM
    lazy var songsSearchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.isAccessibilityElement = true
        searchController.searchBar.searchTextField.accessibilityIdentifier = "songsSearchBar"
        searchController.searchBar.placeholder = "Search Songs"
        searchController.searchResultsUpdater = self
        
        return searchController
    }()
    
    
    var songsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "songsTableView"
        tableView.register(NoResultTableCell.self, forCellReuseIdentifier: NoResultTableCell.description())
        tableView.register(ResultTableCell.self, forCellReuseIdentifier: ResultTableCell.description())
        return tableView
    }()
    
    var errorLable : UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 24)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Something went wrong!"
        return lable
    }()

    
    init(with homeVM: HomeVM) {
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVM.reloadData = { [weak self] in
            self?.songsTableView.isHidden = false
            self?.songsTableView.reloadData()
        }
        
        homeVM.passError = { [weak self] (error) in
            DispatchQueue.main.async {
                self?.errorLable.text = error.localizedDescription
                self?.songsTableView.isHidden = true
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        setupNavigationBar()
        setupViews()
    }
    
}

//MARK: - UI Methods
extension HomeVC {
    func setupViews() {
        view.addSubview(errorLable)
        view.addSubview(songsTableView)
        
        let margings = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            songsTableView.topAnchor.constraint(equalTo: margings.topAnchor),
            songsTableView.bottomAnchor.constraint(equalTo: margings.bottomAnchor),
            
            errorLable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorLable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationItem.searchController = songsSearchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        
    }
}


extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Search \(String(describing: songsSearchController.searchBar.text))")
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            homeVM.getSearchResult(searchText)
        } else {
            homeVM.itunesResults = []
            songsTableView.reloadData()
        }
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.itunesResults.isEmpty ? 1 : homeVM.itunesResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if homeVM.itunesResults.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoResultTableCell.description())
                    as? NoResultTableCell else { return UITableViewCell() }
            let text = homeVM.searchedText.isEmpty ? "You have not searched for anything!" : "No result found!"
            cell.configureCell(text)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableCell.description())
                as? ResultTableCell else { return UITableViewCell() }
        cell.accessibilityIdentifier = "result_cell_\(indexPath.row)"
        cell.configureCell(homeVM.itunesResults[indexPath.row])
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if homeVM.itunesResults.isEmpty {
            return tableView.frame.size.height
        }
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let showDetail = showDetail, !homeVM.itunesResults.isEmpty {
            let result = homeVM.itunesResults[indexPath.row]
            showDetail(result)
        }
    }
}
