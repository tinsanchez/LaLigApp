//
//  QRCodeCaptureWireframe.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class QRCodeCaptureWireframe: BaseWireframe, QRCodeCaptureWireframeContract {
    
    weak var output: QRCodeCaptureWireframeOutputContract!
    weak var view: UIViewController!

    weak var loadingDelegate: LoadingViewDelegate!

    /// Show basic loading
    /// - Parameters:
    ///   - text: text
    func showBasicLoading(text: String) {
        let loadingVC = LoadingViewController()
        self.loadingDelegate = loadingVC
        
        self.presentView(from: self.view, useCase: loadingVC, withTransition: .modal,
                         modalPresentationStyle: .overCurrentContext, animated: false, completion: {
            loadingVC.updateTitle(with: text)
        })
    }
    
    /// Hide basic loading
    func hideBasicLoading(completion: @escaping (() -> Void)) {
        self.loadingDelegate?.dismiss {
            completion()
        }
    }
    
    func openURL(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) == true {
                UIApplication.shared.open(url)
            } else {
                self.showCustomModalAlert(self.view, title: "Web does not found".localizedString(),
                                          content: "try again.".localizedString(), completion: nil)
            }
        } else {
            print("QR Code does not contain a valid URL")
            self.showCustomModalAlert(self.view, title: "QR not founded".localizedString(),
                                      content: "QR Code does not contain a web".localizedString(), completion: nil)
            return
        }
    }
}
