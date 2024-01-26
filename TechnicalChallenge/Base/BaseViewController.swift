//
//  BaseViewController.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import UIKit
import Alamofire
import SVProgressHUD

protocol BaseViewControllerProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ error: ServiceError)
}

class BaseViewController: UIViewController {
        
    private let networkReachability = NetworkReachabilityManager()!
    private var skip: Int = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLocalization()
        networkReachability.startListening { [weak self] status in
            guard let self = self else { return }
            if status == .notReachable || status == .unknown {
                self.connectionDisconnected()
                self.skip = 1
            } else {
                if self.skip != 0 {
                    self.connectionReconnected()
                }
            }
        }
    }
    
    func applyLocalization() {}
       
    func addObserverKeyBoard() {
           NotificationCenter.default.addObserver(self,
                                    selector: #selector(keyboardWillShowNotification),
                                    name: UIResponder.keyboardWillShowNotification,
                                    object: nil)
           NotificationCenter.default.addObserver(self,
                                    selector: #selector(keyboardWillHideNotification),
                                    name: UIResponder.keyboardWillHideNotification,
                                    object: nil)
    }
       
    func updateLayoutWhenKeyboardChanged(height: CGFloat) {}
       
    func connectionDisconnected() {
        print("[Reachibility]: Disconnected")
    }
       
    func connectionReconnected() {
        print("[Reachibility]: Reconnected")
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
    func showError(_ error: ServiceError) {
        SVProgressHUD.showError(withStatus: error.message)
        SVProgressHUD.dismiss(withDelay: 1.5)
    }
}

private extension BaseViewController {
    @objc func keyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let heightSafeArea = UIApplication.shared.mainKeyWindow?.safeAreaInsets.bottom ?? 0.0
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        updateLayoutWhenKeyboardChanged(height: keyboardHeight - heightSafeArea + 5)
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        updateLayoutWhenKeyboardChanged(height: 0)
    }
}
