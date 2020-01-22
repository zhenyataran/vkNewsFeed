//
//  ProfileViewController.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/23/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
   // var profile: ProfileResponse! = nil
    
      private let firstNameLabel = UILabel()
      private let lastNameLabel = UILabel()
      private let bDateLabel = UILabel()
      private let cityLabel = UILabel()
      private let countryLabel = UILabel()
      private let homeTownLabel = UILabel()
      private let sexLabel = UILabel()
      private let statusLabel = UILabel()
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        NetworkProvider.request(target: .getProfile, success: { (response) in
            do {
                let profile  = try response.map(to: ProfileResponse.self)
                activityIndicator.stopAnimating()
                self.setUI(with: profile.responseProfile)
            } catch let error {
                print("ERRR:\(error)")
                self.displayAlert(title: "error", with: error.localizedDescription)
            }
            print(response)
        }, error: { (error) in
            print(error)
        }) { (error) in
            print("MoyaError \(error)")
        }
        
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
}

extension ProfileViewController {
    private func setUI(with profile: ProfileVK) {
        self.view.addSubViews(to: firstNameLabel,
                              lastNameLabel,
                              bDateLabel,
                              cityLabel,
                              countryLabel,
                              homeTownLabel,
                              sexLabel,
                              statusLabel)
        
        firstNameLabel.textColor = .blue
        lastNameLabel.textColor = .blue
        bDateLabel.textColor = .blue
        cityLabel.textColor = .blue
        countryLabel.textColor = .blue
        homeTownLabel.textColor = .blue
        sexLabel.textColor = .blue
        statusLabel.textColor = .blue
        
        firstNameLabel.text = "first Name: \(profile.firstName)"
        lastNameLabel.text = "last Name: \(profile.lastName)"
        bDateLabel.text = "Birthday Date: \(profile.bDate)"
        cityLabel.text = "Current city: \(profile.city.tittle)"
        countryLabel.text = "Current country: \(profile.country.tittle)"
        homeTownLabel.text = "Home town: \(profile.homeTown)"
        sexLabel.text = "Gender: "
        switch profile.sex {
        case 1:
            sexLabel.text! += "female"
        case 2:
            sexLabel.text! += "male"
        default:
            sexLabel.text! += "gender not specified"
        }
        statusLabel.isHidden = true
        if !profile.status.isEmpty {
            statusLabel.text = "Status \(profile.status)"
            statusLabel.isHidden = false
        }
    }
    
    private func layout() {
        
        firstNameLabel.pin
            .hCenter()
            .vCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        lastNameLabel.pin.below(of: firstNameLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        bDateLabel.pin.below(of: lastNameLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        cityLabel.pin.below(of: bDateLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        countryLabel.pin.below(of: cityLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        homeTownLabel.pin.below(of: countryLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        sexLabel.pin.below(of: homeTownLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
        statusLabel.pin.below(of: sexLabel).marginTop(10)
            .hCenter()
            .height(20)
            .sizeToFit(.widthFlexible)
        
    }
}
