//
//  ImageFireBaseManager.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import FirebaseStorage
import RxSwift
import RxCocoa
import Alamofire

class ImageFireBaseManager {
    let storage = Storage.storage()
    let storageURL = "https://firebasestorage.googleapis.com/v0/b/carrotclone-15396.appspot.com/o/"
    
    func uploadImage(img: UIImage) -> Single<String> {
        return Single<String>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            var data = Data()
            guard let jpg = img.jpegData(compressionQuality: 0.8) else {
                single(.failure(Error.self as! Error))
                return Disposables.create()
            }
            data = jpg
            let filePath = Date().toString()
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            self.storage.reference().child(filePath).putData(data, metadata: metaData){
                (metaData, error) in
                if let error = error {
                    single(.failure(error))
                    return
                } else {
                    single(.success(filePath))
                }
                
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
}
