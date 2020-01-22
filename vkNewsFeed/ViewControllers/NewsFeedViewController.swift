//
//  NewsFeedViewController.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit
import Mapper
import Moya_ModelMapper

class NewsFeedViewController: UIViewController {
    
    var newsFeed: FeedResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkProvider.request(target: .getNews,
            success: { (response) in
                do {
                    self.newsFeed = try response.map(to: FeedResponse.self)
                    print(response)
                } catch {
                    self.displayAlert(title: "erroe", with: "cant't parse data")
                }
            }, error: { (error) in
            print(error)
            }) { (error) in
            print("MoyaError \(error)")
            }
        view.backgroundColor = .red
    }
}
