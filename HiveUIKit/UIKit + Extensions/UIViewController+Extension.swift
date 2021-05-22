//
//  UIAlertController+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 25.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
