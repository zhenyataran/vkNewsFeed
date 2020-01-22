//
//  FeedModel.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import Mapper

struct FeedResponse: Mappable {
    let responseFeed: FeedItems
    
    init(map: Mapper) throws {
        try responseFeed = map.from("response")
       }
}

struct FeedItems: Mappable {
    let items: [FeedItem]
    
    init(map: Mapper) throws {
        try items = map.from("items")
    }
}

struct FeedItem: Mappable {
    
    let sourceID: Int
    let postID: Int
    let text: String?
    let date: Double
    let comments: Int
    let likes: countItem
    let views: countItem
    let reposts: countItem?
    let attachments: [Attachment]?
    
    init(map: Mapper) throws {
        try sourceID = map.from("source_id")
        try postID = map.from("post_id")
        try text = map.optionalFrom("text")
        try date = map.from("date")
        try comments = map.from("comments")
        try likes = map.from("likes")
        try views = map.from("views")
        try reposts = map.from("reposts")
        try attachments = map.optionalFrom("attachments")
    }
    
    
}

struct Attachment: Mappable {
    
    let photos: Photo?
    
    init(map: Mapper) throws {
        try photos = map.optionalFrom("photo")
    }
    
}

struct Photo: Mappable {
    let sizes: [PhotoSize]
    
    init(map: Mapper) throws {
        try sizes = map.from("sizes")
    }
    
    var height: Int {
        return getSizes().height
    }
    
    var width: Int {
        return getSizes().width
    }
    
    var url: String {
        return getSizes().url
    }
    
    func getSizes() -> PhotoSize {
        if let sizeX = sizes.first(where: {$0.type == "x"}) {
            return sizeX
        } else if let fullSize = sizes.first(where: {$0.type == "z"}) {
            return fullSize
        } else {
            return PhotoSize()
        }
    }
}

struct PhotoSize: Mappable {
    
    let type: String
    let url: String
    let height: Int
    let width: Int
    
    init(map: Mapper) throws {
        try type = map.from("type")
        try url = map.from("url")
        try height = map.from("height")
        try width = map.from("width")
    }
    
    init() {
        self.type = "wrong image"
        self.url = ""
        self.height = 0
        self.width = 0
    }
}

struct countItem: Mappable {
    let count: Int
    
    init(map: Mapper) throws {
        try count = map.from("count")
    }
}
