//
//  UIbuttonExtonsion.swift
//  BlueScan
//
//  Created by Yakoub on 29/01/2021.
//

import UIKit
import Foundation

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.9
        pulse.toValue = 1.15
        pulse.autoreverses = true
        pulse.repeatCount = 0.5
        pulse.initialVelocity = 0.7
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
