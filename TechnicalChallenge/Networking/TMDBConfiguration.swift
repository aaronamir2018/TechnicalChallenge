//
//  TMDBConfiguration.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import Foundation

enum TMDBNetworkingConfiguration {
    case getAPIConfiguration
}

extension TMDBNetworkingConfiguration: Configuration {
    var baseURL: String { return NetworkingConstant.baseUrl }
    
    var path: String {
        switch self {
        case .getAPIConfiguration:
            return "3/configuration"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAPIConfiguration:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAPIConfiguration:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Authorization": "Bearer \(NetworkingConstant.accessToken)"]
        }
    }
    
    var data: Data? {
        return nil
    }
}
