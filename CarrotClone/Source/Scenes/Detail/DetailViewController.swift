//
//  DetailViewController.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/09.
//

import UIKit

class DetailViewController: UITableViewController {
    var coordinator: DetailCoordinator?
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "댓글"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return viewModel!.post.comment.count
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let post = viewModel!.post
        if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            
            cell.update(id: post.commentID[row], comment: post.comments[row])
            cell.selectionStyle = .none
            
            return cell
        } else if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WriterCell", for: indexPath) as! WriterCell
            
            cell.update(id: post.user)
            cell.selectionStyle = .none
            
            return cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
            
            cell.update(content: post.content)
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureCell
            
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: post.pictures.count)
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel!.post.pictures.count)
        return viewModel!.post.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else{
            return UICollectionViewCell()
        }
        
        cell.update((viewModel?.getPicURL(indexPath.row))!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height:  collectionView.frame.height)
    }
    
    
}
