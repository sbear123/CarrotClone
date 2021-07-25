//
//  RegisterViewController.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import UIKit
import SwiftMessages
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    var coordinator: RegisterCoordinator?
    let viewModel = RegisterViewModel()
    var disposeBag = DisposeBag()

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nav = self.navigationController else { return }
        nav.navigationBar.isHidden = true
        bind()
    }
    
    func bind() {
        viewModel.success.bind(onNext: { text in
            AlertPresenter.instance.SuccessAlert(title: "성공", body: text)
            self.coordinator?.popToLogin()
        }).disposed(by: disposeBag)
        
        viewModel.warning.bind(onNext: { text in
            AlertPresenter.instance.WarningAlert(title: "다시 시도해주세요.", body: text)
        }).disposed(by: disposeBag)
        
        viewModel.fail.bind(onNext: { text in
            AlertPresenter.instance.ErrorAlert(title: "Error", body: text)
        }).disposed(by: disposeBag)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        viewModel.SignUp(id: idField, pw: pwField, name: nameField)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        coordinator?.popToLogin()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}
