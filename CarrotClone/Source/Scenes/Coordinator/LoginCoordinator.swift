//
//  LoginCoordinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import UIKit

class LoginCoordinator: Coordinator {
    var presenter: UINavigationController
    var viewModel: LoginViewModel?
    
    init(presenter: UINavigationController, viewModel: LoginViewModel? = LoginViewModel()) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginView = (storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController)!
        loginView.coordinator = self
        presenter.pushViewController(loginView, animated: false)
    }
    
    func pushToMain() {
        let coordinator = MainCoordinator(presenter: presenter)
        coordinator.start()
    }
    
    func pushToRegister() {
        let coordinator = RegisterCoordinator(presenter: presenter)
        coordinator.start()
    }
}
