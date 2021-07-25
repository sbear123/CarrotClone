//
//  MainCoodinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/11.
//

import UIKit

class MainCoordinator: Coordinator {
    var presenter: UINavigationController
    var viewModel: MainViewModel?
    
    init(presenter: UINavigationController, viewModel: MainViewModel? = MainViewModel()) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainView = (storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController)!
        mainView.coordinator = self
        presenter.pushViewController(mainView, animated: false)
    }
    
    func pushToDetail(post: Post) {
        let coordinator = DetailCoordinator(presenter: presenter)
        coordinator.post = post
        coordinator.start()
    }
    
    func pushToWrite() {
        let coordinator = WriteCoordinator(presenter: presenter)
        coordinator.start()
    }
    
}
