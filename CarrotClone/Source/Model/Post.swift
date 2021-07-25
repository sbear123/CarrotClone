//
//  Post.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import Foundation

struct Post: Codable {
    var id: String
    var user: String
    var title: String
    var pictures: [String:String]
    var picturesName: [String]
    var content: String
    var comment: [String:String]
    var commentID: [String]
    var comments: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case title
        case pictures, picturesName
        case content
        case comment, commentID, comments
    }
    
    init() {
        id = ""
        user = ""
        title = ""
        pictures = [:]
        picturesName = []
        content = ""
        comment = [:]
        commentID = []
        comments = []
    }
    
    init(id: String, user: String, title: String, pictures: [String:String], content: String, comment: [String:String]) {
        self.id = id
        self.user = user
        self.title = title
        self.pictures = pictures
        picturesName = Array(pictures.keys.map({ $0 }))
        self.content = content
        self.comment = comment
        commentID = Array(comment.keys.map{ $0 })
        comments = Array(comment.values.map{ $0 })
    }
}
