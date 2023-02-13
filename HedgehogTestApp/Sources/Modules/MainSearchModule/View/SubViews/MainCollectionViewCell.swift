//
//  MainCollectionViewCell.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 10.02.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseId = "MainCollectionViewCell"
    private var imageUrl: String?
    private let imageLoader = ImageLoader.shared
    
    //MARK: - Views
    private var responceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .black
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.isHidden = true
        
        return activityIndicatorView
    }()
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageUrl = nil
        responceImageView.image = nil
    }
}

//MARK: - Private methods
extension MainCollectionViewCell {
    private func setupHierarchy() {
        [
            responceImageView,
            activityIndicatorView
        ].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            responceImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            responceImageView.topAnchor.constraint(equalTo: topAnchor),
            responceImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            responceImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension MainCollectionViewCell: CollectionViewCellConfigurableProtocol {
    func configure(with viewModel: ViewModel) {
        guard let viewModel = viewModel as? ImageDataViewModel else { return }
        activityIndicatorView.startAnimating()
        self.imageUrl = viewModel.imageUrlString
        downloadImage(urlString: imageUrl ?? "")
    }
    
    private func downloadImage(urlString: String) {
        imageLoader.getImage(from: urlString) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self,
                      self.imageUrl == urlString else {
                    return
                }
                
                self.responceImageView.image = image
                
                if self.responceImageView.image != nil {
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
}
