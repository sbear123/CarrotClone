//
//  LoginService.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import RxSwift
import RxCocoa

class LoginService {
    let manager = UserFireBaseManager()
    var disposeBag = DisposeBag()
    var user = PublishRelay<User>()
    var warning = PublishRelay<String>()
    var fail = PublishRelay<String>()
    
    func login(u: User) {
        manager.read(id: u.id).subscribe(
            onSuccess: { user in
                if user.id == "" {
                    self.warning.accept("아이디가 존재하지 않습니다.")
                } else if user.password == u.password {
                    self.user.accept(user)
                } else {
                    self.warning.accept("비밀번호가 틀렸습니다. 다시 작성해 주세요.")
                }
            },
            onFailure: { err in
                self.fail.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
}
