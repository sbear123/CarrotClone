//
//  User.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case password
    }
    
    init() {
        id = ""
        name = ""
        password = ""
    }
    
    init(id: String, password: String) {
        self.id = id
        name = ""
        self.password = password
    }
    
    init(id: String, password: String, name: String) {
        self.id = id
        self.name = name
        self.password = password
    }
}
