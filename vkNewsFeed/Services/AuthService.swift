//
//  AuthService.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/20/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import VK_ios_sdk
import KeychainSwift

protocol AuthDelegate: class {
    func authShow(_ viewController: UIViewController)
    func authSignIn()
    func authFailedSigIn()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    lazy var keyChain = KeychainSwift()
    
    private let appID = "7288702"
    private let vkSDK : VKSdk
    
    weak var delegate: AuthDelegate?
    
    var token: String? {
        get {
            keyChain.get("acces_token")
        }
        set {
            guard let newValue = newValue else { return }
            keyChain.set(newValue, forKey: "acces_token")
        }
    }
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
        
    }
    
    func wakeUp() {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                delegate?.authSignIn()
                self.token = VKSdk.accessToken()?.accessToken
            } else if state == VKAuthorizationState.initialized {
                VKSdk.authorize(scope)
            } else {
                delegate?.authFailedSigIn()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if token != nil {
            delegate?.authSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
