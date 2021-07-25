//
//  ExDate.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter.string(from: self)
    }
}
