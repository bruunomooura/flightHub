//
//  UIButton+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit

extension UIButton {
    // MARK: Animate button tap
       /**
        Animates the button tap by scaling it down slightly and reducing its opacity, then restoring it to its original size and opacity after a short delay.
        
        This creates a tactile feedback effect, improving the user experience during button interactions.
        */
    public func animateTap() {
        animateScaleDown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.animateScaleUp()
        }
    }
    
    // MARK: Scale down the button
       /**
        Scales the button down to 95% of its original size and reduces its opacity to 50%.
        
        This animation is triggered as part of the tap effect to provide visual feedback that the button has been pressed.
        */
    private func animateScaleDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.alpha = 0.5
        }
    }
    
    // MARK: Scale up the button
       /**
        Restores the button to its original size and opacity.
        
        This animation occurs after the scale-down effect, bringing the button back to its normal state after the user releases the tap.
        */
    private func animateScaleUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }
    }
}
