//
//  DetailViewModel.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import RxSwift
import RxCocoa

class DetailViewModel{
    let service = PostService()
    var disposeBag = DisposeBag()
    
    var post = Post()
    var storedOffsets = [Int: CGFloat]()
    
    func getPicURL(_ cnt: Int) -> String {
        let picName = post.picturesName[0]
        return service.URL + picName + "?alt=media&token=" + post.pictures[picName]!
    }
    
}
