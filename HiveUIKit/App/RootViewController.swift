//
//  RootViewController.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.05.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController = SplashViewController()
    
    var farms: Farms?
    var iconsImages = [String : UIImage]()
    {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.switchToFarmsScreen(with: (self?.farms)!)
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("Root \(#function)")
        super.viewDidLoad()
        view.backgroundColor = .red
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        overrideUserInterfaceStyle = .dark
    }
    
    func showLoginScreen() {
        let loginVC = LoginRouter.createLoginModule()
        let new = UINavigationController(rootViewController: loginVC, backButtonHide: true, setTitle: "Your Farms")
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func prepareForSwitchToFarm(with farms: Farms) {
        self.farms = farms
        CoinsIconsFetchSevice.shared.getIconsForCoinsInUse(with: farms, completion: { icons in
            self.iconsImages = icons
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if self.iconsImages.isEmpty == true {
                self.showAlert(with: "Error", and: "Something went wrong, check internet connection")
            }
        }
    }
    
    func switchToFarmsScreen(with farms: Farms) {
        let farmsViewController = FarmsRouter.createFarmsModule(with: farms)
        let farmsVC = UINavigationController(rootViewController: farmsViewController,
                                             backButtonHide: true,
                                             setTitle: "Your Farms")
        self.animateFadeTransition(to: farmsVC)
    }
    
    func switchToLogout() {
       let loginViewController = LoginRouter.createLoginModule()
       let loginVC = UINavigationController(rootViewController: loginViewController, backButtonHide: true, setTitle: "")
       animateDismissTransition(to: loginVC)
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.5, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.6, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}
