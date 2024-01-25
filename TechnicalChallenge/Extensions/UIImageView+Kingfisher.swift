//
//  UIImageView+Kingfisher.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
    
    func cancelImageDownload() {
        kf.cancelDownloadTask()
    }
}
