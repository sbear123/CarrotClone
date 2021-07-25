//
//  RegisterCoordinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit

class RegisterCoordinator: Coordinator {
    var presenter: UINavigationController
    var viewModel: RegisterViewModel?
    
    init(presenter: UINavigationController, viewModel: RegisterViewModel? = RegisterViewModel()) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let registerView = (storyboard.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController)!
        registerView.coordinator = self
        presenter.pushViewController(registerView, animated: false)
    }
    
    func popToLogin() {
        presenter.popViewController(animated: true)
    }
}
