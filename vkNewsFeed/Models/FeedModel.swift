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
    let profiles: [Profile]
    let groups: [Group]

    
    init(map: Mapper) throws {
        try items = map.from("items")
        try profiles = map.from("profiles")
        try groups = map.from("groups")
    }
}

struct FeedItem: Mappable {
    
    let sourceID: Int
    let postID: Int
    let text: String?
    let date: Double
    let comments: countItem?
    let likes: countItem?
    let views: countItem?
    let reposts: countItem?
    let attachments: [Attachment]?
    
    init(map: Mapper) throws {
        try sourceID = map.from("source_id")
        try postID = map.from("post_id")
        try text = map.optionalFrom("text")
        try date = map.from("date")
        try comments = map.optionalFrom("comments")
        try likes = map.optionalFrom("likes")
        try views = map.optionalFrom("views")
        try reposts = map.optionalFrom("reposts")
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

protocol ProfileOrGroup {
    var id: Int { get }
    var photo: String { get }
    var name: String { get }
}

struct Profile: Mappable, ProfileOrGroup {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try firstName = map.from("first_name")
        try lastName = map.from("last_name")
        try photo100 = map.from("photo_100")
    }
    
    var name: String {
        return firstName + " " + lastName
    }

    var photo: String { return photo100 }
}

struct Group: Mappable, ProfileOrGroup {
    let id: Int
    let name: String
    let photo100: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try photo100 = map.from("photo_100")
    }
    
    var photo: String { return photo100}
}
