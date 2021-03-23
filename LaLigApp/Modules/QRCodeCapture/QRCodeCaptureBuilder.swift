//
//  QRCodeCaptureBuilder.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class QRCodeCaptureBuilder {

    static func build() -> QRCodeCaptureView {
        let view = QRCodeCaptureView.init(nibName: String(describing: QRCodeCaptureView.self), bundle: nil)
        
        view.tabBarItem = UITabBarItem(title: "QRCode".localizedString(), image: UIImage(systemName: "qrcode"), tag: 0)
        
        let presenter = QRCodeCapturePresenter()
        let entity = QRCodeCaptureEntity()
        let wireframe = QRCodeCaptureWireframe()
        
        // let provider = MyProvider()
        // let interactor = QRCodeCaptureInteractor(provider: provider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        // view.presenter.interactor = interactor
        // view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe.output = presenter
        view.presenter.wireframe.view = view
        
        return view
    }
}
