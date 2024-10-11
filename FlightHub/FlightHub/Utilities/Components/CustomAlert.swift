//
//  CustomAlert.swift
//  FlightHub
//
//  Created by Bruno Moura on 11/10/24.
//

import Foundation
import UIKit

// MARK: CustomAlert
/**
 A class that presents customizable alert dialogs.
 
 The `CustomAlert` class provides methods to display both informational and confirmation alerts with customizable titles, messages, and button titles. This class helps to streamline alert presentation and improve the user experience by allowing consistent styling and behavior across the application.
 */
final class CustomAlert {
    private let presenter: AlertPresentable
    
    init(presenter: AlertPresentable) {
        self.presenter = presenter
    }
    
    // MARK: Present information alert
    /**
     Presents an informational alert with a title and message.
     
     - Parameters:
     - title: The title of the alert.
     - message: The message displayed in the alert.
     - buttonTitle: The title of the confirmation button (default is "useful.ok.localized").
     */
    public func alertInformation(
        title: String,
        message: String,
        buttonTitle: String = "useful.ok".localized) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            
            let titleAttrString = NSAttributedString(string: title, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.background
            ])
            
            let messageAttrString = NSAttributedString(string: message, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.background
            ])
            
            alertController.setValue(titleAttrString, forKey: "attributedTitle")
            alertController.setValue(messageAttrString, forKey: "attributedMessage")
            
            let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in }
            
            alertController.addAction(okAction)
            presenter.presentAlert(alertController)
        }
    
    // MARK: Present confirmation alert
    /**
     Presents a confirmation alert with a title, message, and action handlers.
     
     - Parameters:
     - title: The title of the alert.
     - message: The message displayed in the alert.
     - confirmTitle: The title of the confirmation button (default is "useful.confirm.localized").
     - cancelTitle: The title of the cancel button (default is "useful.cancel.localized").
     - confirmHandler: A closure to be executed when the confirmation button is tapped.
     */
    public func alertConfirmation(
        title: String,
        message: String,
        confirmTitle: String = "useful.confirm".localized,
        cancelTitle: String = "useful.cancel".localized,
        confirmHandler: @escaping () -> Void) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            
            let titleAttrString = NSAttributedString(string: title, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.background
            ])
            
            let messageAttrString = NSAttributedString(string: message, attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.background
            ])
            
            alertController.setValue(titleAttrString, forKey: "attributedTitle")
            alertController.setValue(messageAttrString, forKey: "attributedMessage")
            
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmHandler()
            }
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in }
            cancelAction.setValue(UIColor.red.withAlphaComponent(0.7), forKey: "titleTextColor")
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            presenter.presentAlert(alertController)
        }
}
