//
//  OrientationForViewExtension.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 22/3/21.
//

import Foundation
import UIKit

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
}
