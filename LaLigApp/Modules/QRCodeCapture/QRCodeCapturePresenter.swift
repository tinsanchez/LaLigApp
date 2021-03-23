//
//  QRCodeCapturePresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class QRCodeCapturePresenter: BasePresenter, QRCodeCapturePresenterContract {

    weak var view: QRCodeCaptureViewContract!
    var interactor: QRCodeCaptureInteractorContract!
    var entity: QRCodeCaptureEntityContract!
    var wireframe: QRCodeCaptureWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
    
    func showNotSuportedAlert() {
        wireframe.showCustomModalAlert(wireframe.view,
                                       title: "Scanning not supported".localizedString(),
                                       content: "Your device does not support scanning a code.".localizedString(), completion: nil)
    }
    
    func capturedURL(url: String) {
        wireframe.openURL(url: url)
    }
}

// MARK: - QRCodeCaptureInteractorOutputContract
extension QRCodeCapturePresenter: QRCodeCaptureInteractorOutputContract {
    
}

// MARK: - QRCodeCaptureWireframeOutputContract
extension QRCodeCapturePresenter: QRCodeCaptureWireframeOutputContract {
    
}
