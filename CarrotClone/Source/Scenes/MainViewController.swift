//
//  MainViewController.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/21.
//

import UIKit
import AsyncDisplayKit

class MainViewController: ASDKViewController<ASTableNode> {

    override init() {
        super.init(node: ASTableNode.init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
