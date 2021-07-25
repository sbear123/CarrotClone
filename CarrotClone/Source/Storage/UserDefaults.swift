//
//  UserDefaults.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import Foundation

final class UserDefults {
    public static let instance: UserDefults = UserDefults()
    
    func getUserData() -> User {
        var user: User = User()
        guard let id = getData("id") else { return user }
        guard let password = getData("password") else { return user }
        guard let name = getData("name") else { return user }
        user.id = id
        user.password = password
        user.name = name
        return user
    }
    
    func setUserData(_ user: User) {
        UserDefaults.standard.set(user.id, forKey: "id")
        UserDefaults.standard.set(user.password, forKey: "password")
        UserDefaults.standard.set(user.name, forKey: "name")
    }
    
    func deleteUserData() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "name")
    }
    
    private func getData(_ key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}
