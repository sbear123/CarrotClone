//
//  Writer.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit
import RxSwift

class WriterCell: UITableViewCell {
    let service = PostService()
    var disposeBag = DisposeBag()
    
    @IBOutlet var name: UILabel!
    @IBOutlet var id: UILabel!
    
    func update(id: String) {
        service.getUser(id).subscribe(
            onSuccess: { user in
                self.name.text = user.name
                self.id.text = "@" + user.id
            }, onFailure: { err in
                self.name.text = ""
                self.id.text = "@"
            }
        ).disposed(by: disposeBag)
    }
}
