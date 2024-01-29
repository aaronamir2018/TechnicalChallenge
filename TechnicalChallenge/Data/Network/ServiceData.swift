//
//  ServiceData.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation
import Alamofire

protocol ServiceDataProtocol {
    func getServiceRequest(url: String, completion: @escaping (Result<Any?, NSError>) -> Void)
}

class ServiceData: ServiceDataProtocol {
    private var sessionManager: Session?

    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30

        self.sessionManager = Session(configuration: configuration)
    }

    func getServiceRequest(url: String, completion: @escaping (Result<Any?, NSError>) -> Void) {
        let url = url
        self.sessionManager?.request(url).validate().responseData(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                let newError = NSError(domain: url, code:
                                        (response.response?.statusCode ?? 0)!,
                                       userInfo:[NSLocalizedDescriptionKey:error.localizedDescription])
                completion(.failure(newError))
            }
        })
    }
}
