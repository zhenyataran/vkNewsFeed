//
//  NetworkLayer.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import Moya
import KeychainSwift

enum ServiceApi {
    
    case getNews
}

extension ServiceApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.vk.com")!
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "https://api.vk.com"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
         switch self {
         case .getNews():
            let key = KeychainSwift()
            var params = [String: Any]()
            params["filters"] = "post,photo"
            params["acces_token"] = key.get("acces_token")
            params["v"] = "5.103"
            return params
         default:
             return nil
         }
     }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNews:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
