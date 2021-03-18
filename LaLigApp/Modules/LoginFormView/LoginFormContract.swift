//
//  LoginFormContract.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol LoginFormEntityContract: BaseEntity {
    
}

protocol LoginFormViewContract: BaseViewController {
    var presenter: LoginFormPresenterContract! { get set }
    
}

protocol LoginFormPresenterContract: BasePresenter {
    var view: LoginFormViewContract! { get set }
    var interactor: LoginFormInteractorContract! { get set }
    var entity: LoginFormEntityContract! { get set }
    var wireframe: LoginFormWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol LoginFormInteractorContract: BaseInteractor {
    var output: LoginFormInteractorOutputContract! {get set}
}

protocol LoginFormInteractorOutputContract: class {
    
}

protocol LoginFormWireframeContract: BaseWireframe {
    var output: LoginFormWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol LoginFormWireframeOutputContract: class {

}
