//
//  ProfileModel.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/23/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import Mapper

struct ProfileResponse: Mappable {
    let responseProfile: ProfileVK
    
    init(map: Mapper) throws {
        try responseProfile = map.from("response")
    }
    
}

struct ProfileVK: Mappable {
    let firstName: String
    let lastName: String
    let bDate: String
    let bDateVisibility: Int
    let city: City
    let country: Country
    let homeTown: String
    let sex: Int
    let status: String
    
    init(map: Mapper) throws {
        try firstName = map.from("first_name")
        try lastName = map.from("last_name")
        try bDate = map.from("bdate")
        try bDateVisibility = map.from("bdate_visibility")
        try city = map.from("city")
        try country = map.from("country")
        try homeTown = map.from("home_town")
        try sex = map.from("sex")
        try status = map.from("status")
    }
}

struct City: Mappable {
    let id: Int
    let tittle: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try tittle = map.from("title")
    }
}

struct Country: Mappable {
    let id: Int
    let tittle: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try tittle = map.from("title")
    }
}
