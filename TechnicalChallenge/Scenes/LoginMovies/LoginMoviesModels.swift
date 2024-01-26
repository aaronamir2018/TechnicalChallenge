//
//  LoginMoviesModels.swift
//  TechnicalChallenge
//
//  Created by Luis Purizaga on 26/01/24.
//

import UIKit

enum Login {
    enum Login {
        struct Request {
            let username, password: String
        }
        
        struct Response {
            
        }

        struct ViewModelSuccess{
            let succesMessage: String
        }
        
        struct ViewModelFailure{
            let errorMessage: String
        }
    }
}
