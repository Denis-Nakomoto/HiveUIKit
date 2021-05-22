//
//  UINavigationController+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    convenience init(rootViewController: UIViewController, titleTextColor: UIColor? = .white, largeTitleTextColor: UIColor? = .white, barTintColor: UIColor? = .black, backButtonHide: Bool, setTitle: String) {
        
        self.init(rootViewController: rootViewController)
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        
        if backButtonHide {
            self.navigationItem.leftBarButtonItem = backButton
        }
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleTextColor!]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: largeTitleTextColor!]
        self.navigationController?.navigationBar.barTintColor = barTintColor!
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = setTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
