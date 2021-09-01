//
//  RigView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 31.08.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class RigViewController: UIViewController, RigViewProtocol {

    var presenter: RigPresenterProtocol?
    
    var worker: Worker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}
