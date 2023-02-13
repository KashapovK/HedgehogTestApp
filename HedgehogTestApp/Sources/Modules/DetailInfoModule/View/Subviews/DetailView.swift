//
//  DetailView.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: - Properties
    private let imageLoader = ImageLoader.shared
    
    // MARK: - Views
    private var responceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemOrange
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    var detailButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: "safari", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: "arrowshape.right", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        
        return button
    }()
    
    var previousButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: "arrowshape.left", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        
        return button
    }()
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension DetailView {
    private func setupHierarchy() {
        [
            responceImageView,
            stackView
        ].forEach { addSubview($0) }
        
        [
            previousButton,
            detailButton,
            nextButton
        ].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            responceImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            responceImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            responceImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            responceImageView.heightAnchor.constraint(equalToConstant: 400),
            
            stackView.leadingAnchor.constraint(equalTo: responceImageView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: responceImageView.bottomAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: responceImageView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension DetailView: DetailViewConfigurableProtocol {
    func configureView(with viewModel: ViewModel) {
        guard let viewModel = viewModel as? ImageDataViewModel else { return }
        let imageUrl = viewModel.imageUrlString
        downloadImage(urlString: imageUrl)
    }
    
    private func downloadImage(urlString: String) {
        imageLoader.getImage(from: urlString) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.responceImageView.image = image
            }
        }
    }
}
