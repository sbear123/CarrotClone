//
//  MainViewModel.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import RxSwift
import RxCocoa

class MainViewModel {
    let service = PostService()
    var disposeBag = DisposeBag()
    
    var lastLoad = PublishRelay<String>()
    var list = BehaviorRelay(value: [Post]())
    var err = PublishRelay<String>()
    
    init() {
        service.err.bind(onNext: { text in
            self.err.accept(text)
        }).disposed(by: disposeBag)
        
        service.postList.bind(onNext: { list in
            self.list.accept(list)
        }).disposed(by: disposeBag)
        
        service.finishLoad.bind(onNext: { text in
            self.lastLoad.accept(text)
        }).disposed(by: disposeBag)
    }
    
    func getList() {
        service.getPosts()
    }
    
}
