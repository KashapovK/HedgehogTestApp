//
//  DetailInfoViewController.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

final class DetailInfoViewController: UIViewController {
    
    // MARK: - Views
    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    // MARK: - Properties
    let presenter: DetailInfoPresenterInputProtocol
    
    // MARK: - Initialize
    init(presenter: DetailInfoPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.configureViewWithCurrentViewModel()
    }
    
    // MARK: - Private methods
    private func setupView() {
        title = "Preview Image"
        view.backgroundColor = .white
        detailView?.nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        detailView?.previousButton.addTarget(self, action: #selector(tapPreviousButton), for: .touchUpInside)
        detailView?.detailButton.addTarget(self, action: #selector(tapToDetailButton), for: .touchUpInside)
    }
    
    @objc private func tapNextButton() {
        presenter.nextImageData()
    }
    
    @objc private func tapPreviousButton() {
        presenter.prevImageData()
    }
    
    @objc private func tapToDetailButton() {
        presenter.openImageDataInWebView()
    }
}

// MARK: - DetailInfoPresenterOutputProtocol methods
extension DetailInfoViewController: DetailInfoPresenterOutputProtocol {
    func configureView(with viewModel: ViewModel) {
        detailView?.configureView(with: viewModel)
    }
}

