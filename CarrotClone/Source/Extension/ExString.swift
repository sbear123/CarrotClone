//
//  ExString.swift
//  CarrotClone
//
//  Created by 박지현 on 2021/07/23.
//

import Foundation

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) { return date }
        else { return nil }
    }
}
