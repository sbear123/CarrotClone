//
//  RegisterViewModel.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewModel {
    let service = RegisterService()
    var disposeBag = DisposeBag()
    
    var fail = PublishRelay<String>()
    var success = PublishRelay<String>()
    var warning = PublishRelay<String>()
    
    init() {
        service.success.bind(onNext: { text in
            self.success.accept(text)
        }).disposed(by: disposeBag)
        
        service.warning.bind(onNext: { text in
            self.warning.accept(text)
        }).disposed(by: disposeBag)
        
        service.fail.bind(onNext: { text in
            self.fail.accept(text)
        }).disposed(by: disposeBag)
    }
    
    func SignUp(id: UITextField, pw: UITextField, name: UITextField) {
        guard let id = id.text else { return }
        guard let pw = pw.text else { return }
        guard let name = name.text else { return }
        if checkNil(id) || checkNil(pw) || checkNil(name) {
            warning.accept("작성하지 않은 곳이 있습니다.")
            return
        }
        let user = User(id: id, password: pw, name: name)
        print(user)
        service.register(u: user)
    }
    
    func checkNil(_ text: String) -> Bool{
        return text.trimmingCharacters(in: .whitespaces) == ""
    }
}
