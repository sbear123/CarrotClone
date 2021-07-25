//
//  ImageCell.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet var pic: UIImageView!
    
    func update(_ urlString: String) {
        pic.image = nil
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        URLSession.shared.dataTask(with: URL(string: encodedString)!) { (data, response, err) in
            if let data = data {
                DispatchQueue.main.async {
                    self.transition(toImage: UIImage(data: data))
                }
            }
        }.resume()
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.pic.image = image
                          },
                          completion: nil)
    }
}
