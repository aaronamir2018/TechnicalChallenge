//
//  LoginMoviesViewController.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 26/01/24.
//

import UIKit

protocol LoginMoviesViewProtocol: AnyObject {
    func showListMovies()
    func showAlert(title:String?, message: String?)
}

final class LoginMoviesViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var presenter: LoginMoviesPresenterProtocol?
    var configurator: LoginMoviesConfiguratorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurator = LoginMoviesConfigurator()
        configurator?.configureMovies(viewController: self)
        
        self.setupView()
    }
}

extension LoginMoviesViewController {
    func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
        view.isUserInteractionEnabled = true
        
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc func handleViewTap() {
        view.endEditing(true)
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        self.presenter?.goValidateUser(userName: self.userTextField.text, password: self.passwordTextField.text)
    }
}

extension LoginMoviesViewController: LoginMoviesViewProtocol {
    func showListMovies() {
        self.presenter?.goToListMovies()
    }
    
    func showAlert(title: String?, message: String?) {
        self.presenter?.goToShowError(title: title ?? "", message: message ?? "")
    }
}
