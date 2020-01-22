//
//  DownloadImage.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/22/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImage(from url: String?) {
        guard let url = url, let URL = URL(string: url) else {
            self.image = nil
            return
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: URL)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        getData(from: URL, completion: { data, response, error in
            guard let data = data, let response = response , error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.handleLoadedImage(data: data, response: response)
            }
        })
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
    
    private func getData(from url: URL, completion: @escaping( Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
