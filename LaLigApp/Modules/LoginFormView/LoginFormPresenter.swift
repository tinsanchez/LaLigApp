//
//  LoginFormPresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class LoginFormPresenter: BasePresenter, LoginFormPresenterContract {

    weak var view: LoginFormViewContract!
    var interactor: LoginFormInteractorContract!
    var entity: LoginFormEntityContract!
    var wireframe: LoginFormWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}

// MARK: - LoginFormInteractorOutputContract
extension LoginFormPresenter: LoginFormInteractorOutputContract {
    
}

// MARK: - LoginFormWireframeOutputContract
extension LoginFormPresenter: LoginFormWireframeOutputContract {
    
}
