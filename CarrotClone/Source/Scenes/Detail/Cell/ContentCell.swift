//
//  Content.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit

class ContentCell: UITableViewCell {
    @IBOutlet weak var content: UILabel!
    
    func update(content: String) {
        self.content.text = content
    }
}
