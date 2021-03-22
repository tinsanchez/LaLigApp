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
        print("codigo en wireframe \(url)")
        if let url = URL(string: url) {
            print("codigo listo para abrir \(url)")
            UIApplication.shared.open(url)
        } else {
            print("error al sacar la url")
            self.showCustomModalAlert(self.view, title: "Web does not found", content: "try again.", completion: nil)
            return
        }
    }
}
