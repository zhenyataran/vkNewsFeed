//
//  AuthViewController.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/20/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit
import PinLayout

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    lazy var sigInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sig In", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(sigIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = AppDelegate.shared().authService
        view.backgroundColor = .blue
        setUI()
    }
}

extension AuthViewController {
    
    func setUI() {
        view.addSubViews(to: sigInButton)
        sigInButton.pin.vCenter().hCenter().height(30).sizeToFit(.widthFlexible)
//        sigInButton.pin.hCenter().vCenter().size(30)
    }
    
    @objc func sigIn(selector: UIButton) {
        authService.wakeUp()
    }
}
