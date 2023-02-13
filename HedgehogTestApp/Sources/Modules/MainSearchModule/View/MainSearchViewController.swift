//
//  MainSearchViewController.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

class MainSearchViewController: UIViewController {
    
    // MARK: - Views
    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search start here..."
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = false
        return searchController
    }()
    
    // MARK: - Properties
    
    let presenter: MainSearchPresenterInputProtocol
    private var cellViewModels: [ViewModel] = []
    
    // MARK: - Initialize
    init(presenter: MainSearchPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    // MARK: - Private methods
    private func setupView() {
        mainView?.collectionView.delegate = self
        mainView?.collectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        title = "Find Image"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - MainSearchPresenterOutputProtocol
extension MainSearchViewController: MainSearchPresenterOutputProtocol {
    
    func configureView(with viewModel: [ViewModel]) {
        cellViewModels = viewModel
        DispatchQueue.main.async {
            self.mainView?.collectionView.reloadData()
            self.mainView?.activityIndicatorView.stopAnimating()
        }
    }
    
    func configureAlert(with error: NetworkError) {
        let okAction = UIAlertAction(title: "Okey:<", style: .default)
        
        DispatchQueue.main.async {
            self.showAlert(title: "Something went wrong...",
                           message: "\(error.errorDescription)",
                           actions: [okAction])
        }
    }
    
    func didSelectImage(with currentViewModel: ViewModel) {
        presenter.pushToDetailInfoViewController(with: currentViewModel, viewModels: cellViewModels)
    }
}

// MARK: - UISearchBarDelegate
extension MainSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text.isEmptyOrNil {
            guard let searchText = searchBar.text else { return }
            mainView?.activityIndicatorView.startAnimating()
            DispatchQueue.global().async {
                self.presenter.getDataFromNet(with: searchText)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.emptyDataResult()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            presenter.emptyDataResult()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.reuseId,
            for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let viewModel = cellViewModels[indexPath.item]
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentViewModel = cellViewModels[indexPath.item] as? ImageDataViewModel else { return }
        didSelectImage(with: currentViewModel)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
