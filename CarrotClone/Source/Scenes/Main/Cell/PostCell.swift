//
//  PostCell.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit
import RxSwift
import Foundation

class PostCell: UITableViewCell {
    let service = PostService()
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var pictureCnt: UILabel!
    
    func update(post: Post) {
        content.text = post.content
        for (name, token) in post.pictures {
            picture.image = nil
            let urlString = service.URL + name + "?alt=media&token=" + token
            let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            URLSession.shared.dataTask(with: URL(string: encodedString)!) { (data, response, err) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.transition(toImage: UIImage(data: data))
                    }
                }
            }.resume()
            break
        }
        if post.pictures.count <= 1 {
            pictureCnt.text = ""
        } else {
            pictureCnt.text = "+\(post.pictures.count - 1)"
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.picture.image = image
                          },
                          completion: nil)
    }
}
