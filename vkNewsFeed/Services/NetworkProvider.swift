//
//  NetworkProvider.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import Moya

struct NetworkProvider {
    static let provider = MoyaProvider<ServiceApi>()
    
    
    static func request(target: ServiceApi,
                        success successCallback: @escaping (Response) -> Void,
                        error errorCallback: @escaping (Swift.Error) -> Void,
                        failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                   // 2:
                   let error = NSError(domain:"com.vsemenchenko.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
        
    }
}
