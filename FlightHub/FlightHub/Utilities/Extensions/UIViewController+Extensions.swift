//
//  UIViewController+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 11/10/24.
//

import Foundation
import UIKit

// MARK: AlertPresentable
/**
 A protocol that defines a method for presenting alerts.
 
 The `AlertPresentable` protocol is designed to standardize the way alerts are presented in the application. Any object conforming to this protocol can present a `UIAlertController`, allowing for a consistent approach to displaying alerts across different view controllers.
 */
protocol AlertPresentable {
    func presentAlert(_ alert: UIAlertController)
}

extension UIViewController: AlertPresentable {
    /**
     Presents a given alert controller with animation.
     
     This method conforms to the `AlertPresentable` protocol and uses the standard presentation method of `UIViewController` to display the alert.
     
     - Parameter alert: The alert controller to be presented.
     */
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
