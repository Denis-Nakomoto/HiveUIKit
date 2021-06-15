//
//  GpusContainerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 05.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class GpuContainerView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupEachGpuView(height: CGFloat = 15,
                          width: CGFloat = 15,
                          spacing: CGFloat,
                          backgroundColor: UIColor = #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1),
                          borderColor: CGColor = #colorLiteral(red: 0.07058823529, green: 0.7921568627, blue: 0.02745098039, alpha: 1)) {
        let gpu = UIView()
        gpu.backgroundColor = backgroundColor
        gpu.layer.borderColor = borderColor
        gpu.layer.borderWidth = 2
        gpu.layer.cornerRadius = 1
        
        view.addSubview(gpu)
        gpu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gpu.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            gpu.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: spacing),
            gpu.heightAnchor.constraint(equalToConstant: height),
            gpu.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
