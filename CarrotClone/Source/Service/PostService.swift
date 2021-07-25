//
//  PostService.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import RxSwift
import RxCocoa

class PostService {
    let postManager = PostFireBaseManager()
    let imageManager = ImageFireBaseManager()
    let userManager = UserFireBaseManager()
    var disposeBag = DisposeBag()
    let URL = "https://firebasestorage.googleapis.com/v0/b/carrotclone-15396.appspot.com/o/"
    
    var err = PublishRelay<String>()
    var writeSuccess = PublishRelay<String>()
    var deleteSuccess = PublishRelay<String>()
    var postList = BehaviorRelay(value: [Post]())
    var list: [Post] = []
    var finishLoad = PublishRelay<String>()
    var imgName = PublishRelay<String>()
    
    func write(_ post: Post, user: User) {
        postManager.post(request: post, user: user).subscribe(
            onSuccess: { id in
                self.writeSuccess.accept(id)
            }, onFailure: { err in
                self.err.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
    
    func getPosts() {
        postManager.read().subscribe(
            onSuccess: { postList in
                if postList.count == 0 {
                    self.finishLoad.accept("더 이상 글이 존재하지 않습니다.")
                } else if postList.count == 1 && self.list.count != 0 {
                    self.finishLoad.accept("더 이상 글이 존재하지 않습니다.")
                } else {
                    self.list.append(contentsOf: postList)
                    self.postList.accept(self.list)
                }
            }, onFailure: { err in
                self.err.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
    
    func delete(_ post: Post) {
        postManager.delete(request: post).subscribe(
            onSuccess: { success in
                if success {
                    self.deleteSuccess.accept("성공적으로 삭제되었습니다.")
                } else {
                    print("글이 삭제 되지 않았습니다.")
                }
            }, onFailure: { err in
                self.err.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
    
    func uploadImage(_ image: UIImage) {
        imageManager.uploadImage(img: image).subscribe(
            onSuccess: { fileName in
                self.imgName.accept(fileName)
            }, onFailure: { err in
                self.err.accept(err.localizedDescription)
                print(err)
            }
        ).disposed(by: disposeBag)
    }
    
    func getUser(_ id: String) -> Single<User> {
        return Single<User>.create{ single in
            let semaphore = DispatchSemaphore(value: 0)
            self.userManager.read(id: id).subscribe(
                onSuccess: { user in
                    print(user.id)
                    single(.success(user))
                    semaphore.signal()
                }, onFailure: { err in
                    single(.failure(err))
                    print(err.localizedDescription)
                    semaphore.signal()
                }
            ).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
}
