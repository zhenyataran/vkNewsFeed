//
//  NewsFeedModel.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/22/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation


struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var iconUrl: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachement: FeedCellPhotoAttachementViewModel?
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachementViewModel {
        var photoUrl: String?
        var height: Int
        var width: Int
    }
    let cells: [Cell]
}
