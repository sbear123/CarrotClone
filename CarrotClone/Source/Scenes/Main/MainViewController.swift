//
//  MainViewController.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/09.
//

import UIKit
import RxSwift

class MainViewController: UITableViewController {
    
    var coordinator: MainCoordinator?
    let viewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nav = self.navigationController else { return }
        nav.navigationItem.rightBarButtonItem = addButton
        tableView.delegate = nil
        tableView.dataSource = nil
        bind()
        viewModel.getList()
    }
    
    func bind() {
        viewModel.err.bind(onNext: { text in
            AlertPresenter.instance.ErrorAlert(title: "Error", body: text)
        }).disposed(by: disposeBag)
        
        viewModel.lastLoad.bind(onNext: { text in
            AlertPresenter.instance.WarningAlert(title: "더이상 데이터가 앖습니다.", body: text)
        }).disposed(by: disposeBag)
        
        viewModel.list.bind(to: (self.tableView?.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self))!) { (row, element, cell) in
            cell.update(post: element)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Post.self)
            .subscribe(onNext:  { item in
                self.coordinator?.pushToDetail(post: item)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.didEndDecelerating
            .subscribe(onNext: {
                if (self.tableView.contentOffset.y + 1) >= (self.tableView.contentSize.height - self.tableView.frame.size.height) {
                    self.viewModel.getList()
                }
            }).disposed(by: disposeBag)
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        coordinator?.pushToWrite()
    }
}
