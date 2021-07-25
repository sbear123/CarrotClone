//
//  Picture.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/24.
//

import UIKit

class PictureCell: UITableViewCell {
    
    @IBOutlet weak var pictures: UICollectionView!
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout, forRow row: Int) {
        pictures.translatesAutoresizingMaskIntoConstraints = false
        pictures.showsHorizontalScrollIndicator = false
        pictures.delegate = dataSourceDelegate
        pictures.dataSource = dataSourceDelegate
        pictures.reloadData()
    }
}
