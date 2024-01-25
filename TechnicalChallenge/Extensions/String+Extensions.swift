//
//  String+Extensions.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import Foundation

extension String {
    var asTrimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func escape() -> String {
        let allowedCharacters = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return allowedCharacters
    }
}
