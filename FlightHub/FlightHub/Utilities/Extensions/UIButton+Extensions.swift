//
//  UIButton+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit

extension UIButton {
    private func animateScaleDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.alpha = 0.5
        }
    }
    
    private func animateScaleUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }
    }
    
    public func animateTap() {
        animateScaleDown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.animateScaleUp()
        }
    }
}
