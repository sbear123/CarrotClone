//
//  WriteCoordinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit

class WriteCoordinator: Coordinator {
    var presenter: UINavigationController
    var viewModel: WriteViewModel?
    
    init(presenter: UINavigationController, viewModel: WriteViewModel? = WriteViewModel()) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Write", bundle: nil)
        let writeView = (storyboard.instantiateViewController(identifier: "WriteViewController") as? WriteViewController)!
        writeView.coordinator = self
        presenter.pushViewController(writeView, animated: false)
    }
    
    func popToMain() {
        presenter.popViewController(animated: true)
    }
    
}
