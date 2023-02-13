//
//  ImageLoaderService.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 11.02.2023.
//

import UIKit

final class ImageLoader: NSObject {
    static var shared = ImageLoader()
    
    private var imageCache = NSCache<NSString, UIImage>()
    private let placeholderImage = UIImage(named: "notFoundBlack")
    
    override init() {
        super.init()
        imageCache.countLimit = 100
    }
    
    func getImage(from url: String, completion: @escaping (_ image: UIImage?) -> Void) {
        if let image = imageCache.object(forKey: url as NSString) {
            completion(image)
        }
        
        guard let photoUrl = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: photoUrl) { [weak self] data, _, _ in
            guard let data = data,
                  let self = self else { return }
            if let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSString)
                completion(image)
            } else {
                completion(self.placeholderImage)
            }
        }
        task.resume()
    }
}
