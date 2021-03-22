//
//  QRCodeCaptureContract.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol QRCodeCaptureEntityContract: BaseEntity {
    
}

protocol QRCodeCaptureViewContract: BaseViewController {
    var presenter: QRCodeCapturePresenterContract! { get set }
    
}

protocol QRCodeCapturePresenterContract: BasePresenter {
    var view: QRCodeCaptureViewContract! { get set }
    var interactor: QRCodeCaptureInteractorContract! { get set }
    var entity: QRCodeCaptureEntityContract! { get set }
    var wireframe: QRCodeCaptureWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    func showNotSuportedAlert()
    func capturedURL(url: String)
}

protocol QRCodeCaptureInteractorContract: BaseInteractor {
    var output: QRCodeCaptureInteractorOutputContract! {get set}
}

protocol QRCodeCaptureInteractorOutputContract: class {
    
}

protocol QRCodeCaptureWireframeContract: BaseWireframe {
    var output: QRCodeCaptureWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
    func openURL(url: String)
}

protocol QRCodeCaptureWireframeOutputContract: class {

}
