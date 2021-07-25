//
//  UserFireBaseManager.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import RxSwift
import Firebase

class UserFireBaseManager: BaseFireBaseManager {
    
    func post(request: User) -> Single<String> {
        let databaseRef = dataBase.collection("/User").document(request.id)
        return Single<String>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.setData([
                "id":request.id,
                "pw":request.password,
                "name":request.name
            ]) { err in
                if let err = err {
                    single(.failure(err))
                } else {
                    single(.success(request.id))
                }
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
    func read(id: String) -> Single<User> {
        let databaseRef = dataBase.collection("/User").document(id)
        return Single<User>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.getDocument { document,error  in
                guard let document = document else {
                    single(.failure(error!))
                    semaphore.signal()
                    return
                }
                if document.exists {
                    single(.success(self.convertUser(data: document)))
                } else {
                    single(.success(User()))
                }
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
}

extension UserFireBaseManager {
    private func convertUser(data: DocumentSnapshot) -> User {
        guard let id = data["id"] as? String else { return User() }
        guard let pw = data["pw"] as? String else { return User() }
        guard let name = data["name"] as? String else { return User() }
        
        return User(id: id, password: pw, name: name)
    }
}
