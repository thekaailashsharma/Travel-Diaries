//
//  StringExt.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import Foundation

extension String {
    func truncate(length: Int, trailing: String = "…") -> String {
        return count > length ? prefix(length) + trailing : self
    }
}
