//
//  ErrorModel.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation

struct ErrorModel: Error {
    var code: Int?
    var description: String?

    init(code: Int?, description: String?) {
        self.code = code
        self.description = description
    }
}
