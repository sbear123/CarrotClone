//
//  LoginViewController.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    let viewModel = LoginViewModel()
    var disposeBag = DisposeBag()

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nav = self.navigationController else { return }
        nav.navigationBar.isHidden = true
        bind()
    }
    
    func bind() {
        viewModel.success.bind(onNext: { text in
            AlertPresenter.instance.SuccessAlert(title: "성공", body: text)
            self.coordinator?.pushToMain()
        }).disposed(by: disposeBag)
        
        viewModel.warning.bind(onNext: { text in
            AlertPresenter.instance.WarningAlert(title: "다시 확인해주십시오.", body: text)
        }).disposed(by: disposeBag)
        
        viewModel.fail.bind(onNext: { text in
            AlertPresenter.instance.ErrorAlert(title: "Error", body: text)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel.Login(id: idField, pw: pwField)
    }
    
    @IBAction func GoRegister(_ sender: Any) {
        coordinator?.pushToRegister()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}
