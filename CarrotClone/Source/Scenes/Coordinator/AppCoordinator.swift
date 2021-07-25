//
//  AppCoordinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    var presenter: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
    }
    
    func start() {
        window.rootViewController = presenter
        if UserDefaults.standard.string(forKey: "id") != nil {
            let coordinator = MainCoordinator(presenter: presenter)
            coordinator.start()
        } else {
            let coordinator = LoginCoordinator(presenter: presenter)
            coordinator.start()
        }
        window.makeKeyAndVisible()
    }
}
