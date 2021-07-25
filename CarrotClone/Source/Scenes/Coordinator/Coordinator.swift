//
//  Coordinator.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var presenter: UINavigationController { get set }
    
    func start()
}

