//
//  LoginViewModel.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    let service = LoginService()
    var disposeBag = DisposeBag()
    
    var fail = PublishRelay<String>()
    var success = PublishRelay<String>()
    var warning = PublishRelay<String>()
    
    init() {
        service.user.bind(onNext: { user in
            UserDefults.instance.setUserData(user)
            self.success.accept("로그인에 성공하였습니다.")
        }).disposed(by: disposeBag)
        
        service.warning.bind(onNext: { text in
            self.warning.accept(text)
        }).disposed(by: disposeBag)
        
        service.fail.bind(onNext: { text in
            self.fail.accept(text)
        }).disposed(by: disposeBag)
    }
    
    func Login(id: UITextField, pw: UITextField) {
        guard let id = id.text else { return }
        guard let pw = pw.text else { return }
        if checkNil(id) || checkNil(pw) {
            warning.accept("작성하지 않은 곳이 있습니다.")
            return
        }
        let user = User(id: id, password: pw)
        service.login(u: user)
    }
    
    func checkNil(_ text: String) -> Bool{
        return text.trimmingCharacters(in: .whitespaces) == ""
    }
}
