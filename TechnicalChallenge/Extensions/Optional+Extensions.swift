//
//  Optional+Extensions.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
