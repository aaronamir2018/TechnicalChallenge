//
//  LoginMoviesViewController.swift
//  TechnicalChallenge
//
//  Created by Luis Purizaga on 26/01/24.
//

import UIKit

protocol LoginMoviesDisplayLogic: AnyObject {
    func displayUser(viewModel: Login.Login.ViewModelSuccess)
    func displayFailure(viewModel: Login.Login.ViewModelFailure)
}

final class LoginMoviesViewController: UIViewController, LoginMoviesDisplayLogic  {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var interactor: LoginMoviesBusinessLogic?
    var router: (NSObjectProtocol & LoginMoviesRoutingLogic)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayUser(viewModel: Login.Login.ViewModelSuccess) {
    }
    
    func displayFailure(viewModel: Login.Login.ViewModelFailure) {
    }
    

    @IBAction func pressLogin(_ sender: Any) {
        if userTextField.text == "Admin" && passwordTextField.text == "Password*123" {
            print("ENTRO")
        } else {
            print("No entro")
        }
    }
}
