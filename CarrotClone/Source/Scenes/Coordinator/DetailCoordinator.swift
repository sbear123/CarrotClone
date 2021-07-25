//
//  DetailCoordinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/09.
//

import UIKit

class DetailCoordinator: Coordinator {
    var presenter: UINavigationController
    var viewModel: DetailViewModel?
    var post: Post?
    
    init(presenter: UINavigationController, viewModel: DetailViewModel? = DetailViewModel()) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailView = (storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController)!
        detailView.coordinator = self
        let vm = DetailViewModel()
        vm.post = post!
        detailView.viewModel = vm
        presenter.pushViewController(detailView, animated: false)
    }
}
