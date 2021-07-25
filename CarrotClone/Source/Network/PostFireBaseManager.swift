//
//  PostFireBaseManager.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import RxSwift
import Firebase

class PostFireBaseManager: BaseFireBaseManager {
    
    var documents = [QueryDocumentSnapshot]()
    
    func post(request: Post, user: User) -> Single<String> {
        var ref: DocumentReference? = nil
        let databaseRef = dataBase.collection("/Post")
        return Single<String>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            ref = databaseRef.addDocument(data:[
                "user":user.id,
                "title":request.title,
                "content":request.content,
                "pictures":request.pictures,
                "comment":request.comment
            ]) {
                $0 == nil ? single(.success(ref!.documentID)) : single(.failure($0!))
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
    func delete(request: Post) -> Single<Bool> {
        let databaseRef = dataBase.collection("/Post")
        return Single<Bool>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.document(request.user).delete() {
                $0 == nil ? single(.success(true)) : single(.failure($0!))
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
    func read() -> Single<[Post]> {
        let databaseRef = dataBase.collection("/Post").limit(to: 20)
        if !documents.isEmpty {
            databaseRef.start(afterDocument: documents.last!)
        }
        return Single<[Post]>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.getDocuments() { (document, err) in
                if let err = err {
                    single(.failure(err))
                } else {
                    guard let document = document else {
                        single(.failure(err!))
                        semaphore.signal()
                        return
                    }
                    
                    single(.success(self.convertMemoList(data: document.documents)))
                }
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
}

extension PostFireBaseManager {
    private func convertMemoList(data:[QueryDocumentSnapshot]) -> Array<Post> {
        documents.append(contentsOf: data)
        var tempPostArray = Array<Post>()
        
        for ad in data {
            guard let user = ad["user"] as? String else { continue }
            guard let title = ad["title"] as? String else { continue }
            guard let pictures = ad["pictures"] as? [String:String] else { continue }
            guard let content = ad["content"] as? String else { continue }
            guard let comment = ad["comment"] as? [String:String] else { continue }
            let m = Post(id: ad.documentID, user: user, title: title, pictures: pictures, content: content, comment: comment)
            tempPostArray.append(m)
        }
        return tempPostArray
    }
}
