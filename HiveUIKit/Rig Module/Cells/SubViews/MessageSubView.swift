//
//  MessageSubView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 09.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class MessageSubView: UIView {
    
    let removeAllMessagesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
//        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let removeMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMessageView(title: String, type: MessageTypes) {
        let messageLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .light), color: .white)
        
        let messagesStack = UIStackView(arrangedSubviews: [], axis: .horizontal, spacing: 2)
        
        switch type {
        case .success:
            messageLabel.textColor = .green
        case .info:
            messageLabel.textColor = .systemBlue
        case .file:
            messageLabel.textColor = .yellow
        case .warning:
            messageLabel.textColor = #colorLiteral(red: 0.9137254902, green: 0.631372549, blue: 0.1647058824, alpha: 1)
        case .danger:
            messageLabel.textColor = .red
        }
        
        messageLabel.text = title
        
        messagesStack.addArrangedSubview(messageLabel)
        messagesStack.addArrangedSubview(removeMessageButton)
        messagesStack.addArrangedSubview(removeAllMessagesButton)
        addSubview(messagesStack)
        
        messagesStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messagesStack.topAnchor.constraint(equalTo: topAnchor),
            messagesStack.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
