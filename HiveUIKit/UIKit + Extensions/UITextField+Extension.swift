//
//  UITextField+Extension.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 27.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

extension UITextField {
    
    convenience init (textAlignment: NSTextAlignment? = .left, cornerRadius: CGFloat? = 5, clipsToBounds: Bool? = true, backgroundColor: UIColor? = #colorLiteral(red: 0.9568627451, green: 0.8235294118, blue: 0.4862745098, alpha: 1), textColor: UIColor? = .darkGray, setLeftPaddingPoints: CGFloat? = 5, string: String, isSecure: Bool? = false) {
        self.init()
        self.attributedPlaceholder = NSAttributedString(string: string,
                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.setLeftPaddingPoints(setLeftPaddingPoints!)
        self.textAlignment = textAlignment!
        self.layer.cornerRadius = cornerRadius!
        self.clipsToBounds = clipsToBounds!
        self.backgroundColor = backgroundColor!
        self.textColor = textColor!
        self.isSecureTextEntry = isSecure!
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
