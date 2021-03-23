//
//  FitSubLayer.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 23/3/21.
//

import Foundation
import UIKit

extension UIView {
  func fitLayers() {
    layer.fit(rect: bounds)
  }
}

extension CALayer {
  func fit(rect: CGRect) {
    frame = rect

    sublayers?.forEach { $0.fit(rect: rect) }
  }
}
