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
    
    func showNoTermsAcceptAlert() {
        wireframe.showCustomModalAlert(wireframe.view, title: "Accept Terms and Conditions",
                                       content: "to register on this platform it is necessary to accept", completion: nil)
    }
    
    func showNoPasswordMatchAlert() {
        wireframe.showCustomModalAlert(wireframe.view, title: "Password does not match",
                                       content: "Please confirm password again", completion: nil)
    }
    
    func sendAction(email: String, password: String) {
        self.interactor.sendLoginData(email: email, password: password)
    }
    
    func showUserCreated() {
        wireframe.showCustomModalAlert(wireframe.view, title: "Register Completed!",
                                       content: "Check your inbox email", completion: nil)
    }
}

// MARK: - LoginFormInteractorOutputContract
extension LoginFormPresenter: LoginFormInteractorOutputContract {
    
}

// MARK: - LoginFormWireframeOutputContract
extension LoginFormPresenter: LoginFormWireframeOutputContract {
    
}
