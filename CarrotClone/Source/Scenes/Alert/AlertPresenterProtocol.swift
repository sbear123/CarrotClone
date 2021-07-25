//
//  AlertPresenterProtocol.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

protocol AlertPresenterProtocol {
    func ErrorAlert(title:String, body: String)
    func WarningAlert(title:String, body: String)
    func SuccessAlert(title:String, body: String)
}
