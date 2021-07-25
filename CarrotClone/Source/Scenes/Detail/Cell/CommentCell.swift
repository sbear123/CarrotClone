//
//  CommentCell.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    func update(id: String, comment: String) {
        self.id.text = id
        self.comment.text = comment
    }

}
