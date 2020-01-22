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
        button.setTitle("Sig In To Vk", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(sigIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = AppDelegate.shared().authService
        view.backgroundColor = .blue
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //self.view.setNeedsLayout()
    }
}

extension AuthViewController {
    
    func setUI() {
        view.addSubViews(to: sigInButton)
        sigInButton.pin.vCenter().hCenter().height(30).sizeToFit(.widthFlexible)
        
        sigInButton.layer.cornerRadius = sigInButton.frame.height / 2
        sigInButton.clipsToBounds = true
    }
    
    @objc func sigIn(selector: UIButton) {
        authService.wakeUp()
    }
}
