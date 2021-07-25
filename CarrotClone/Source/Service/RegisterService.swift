//
//  RegisterService.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import RxSwift
import RxCocoa

class RegisterService {
    let manager = UserFireBaseManager()
    var disposeBag = DisposeBag()
    var success = PublishRelay<String>()
    var fail = PublishRelay<String>()
    var warning = PublishRelay<String>()
    
    func register(u: User) {
        manager.read(id: u.id).subscribe(
            onSuccess: { user in
                print(user)
                if user.id != "" {
                    self.warning.accept("존재하는 아이디입니다.")
                } else {
                    self.makeUser(user: u)
                }
            }, onFailure: { err in
                self.fail.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
    
    func makeUser(user: User) {
        manager.post(request: user).subscribe(
            onSuccess: { id in
                self.success.accept("성공적으로 회원가입되셨습니다. 로그인을 진행해 주십시오.")
            }, onFailure: { err in
                self.fail.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
}
