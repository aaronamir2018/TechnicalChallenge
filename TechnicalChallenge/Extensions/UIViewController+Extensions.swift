//
//  UIViewController+Extensions.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround(isCancelTouchInView: Bool = false) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = isCancelTouchInView
    }
}
