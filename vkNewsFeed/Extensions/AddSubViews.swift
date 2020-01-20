//
//  AddSubViews.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubViews(to view: UIView...) {
        view.forEach {
            self.addSubview($0)
        }
    }
}
