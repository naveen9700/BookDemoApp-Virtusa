//
//  ActivityIndicator.swift
//  BooksDemoAPP
//
//  Created by Naveen on 28/01/24.
//

import Foundation
import UIKit
class ActivityIndicatorManager {
    static let shared = ActivityIndicatorManager()
    private var activityIndicator: UIActivityIndicatorView?
    private init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.hidesWhenStopped = true
    }
    func showActivityIndicator(in view: UIView) {
        guard let activityIndicator = activityIndicator else { return }
        DispatchQueue.main.async {
            activityIndicator.center = view.center
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    func hideActivityIndicator() {
        guard let activityIndicator = activityIndicator else { return }
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
