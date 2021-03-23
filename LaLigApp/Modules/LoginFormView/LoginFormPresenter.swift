//
//  LoginFormPresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class LoginFormPresenter: BasePresenter, LoginFormPresenterContract {

    weak var view: LoginFormViewContract!
    var interactor: LoginFormInteractorContract!
    var entity: LoginFormEntityContract!
    var wireframe: LoginFormWireframeContract!
    
    var confirmed = false

    func viewDidLoad() {
        
    }

    func viewWillAppear() {

    }
    
    func showNoTermsAcceptAlert() {
        wireframe.showCustomModalAlert(wireframe.view,
                                       title: "Accept Terms and Conditions".localizedString(),
                                       // swiftlint:disable line_length
                                       content: "to register on this platform it is necessary to accept".localizedString(), completion: nil)
    }
    
    func registerPressed(email: String, password: String) {
        firstly {
            self.interactor.sendRegisterData(email: email, password: password)
        }.done { [weak self] confirmed in
            self?.confirmed = confirmed
            self?.showUserCreated(confirmed: self?.confirmed)
        }.catch { error in
            print(error)
        }
       
    }
    
    func showUserCreated(confirmed: Bool?) {
        if confirmed == true {
            interactor.sendConfirmationEmail()
            wireframe.showCustomModalAlert(wireframe.view,
                                           title: "Register Completed!".localizedString(),
                                           content: "Check your inbox email".localizedString(), completion: nil)
        }
    }
}

// MARK: - LoginFormInteractorOutputContract
extension LoginFormPresenter: LoginFormInteractorOutputContract {
    
}

// MARK: - LoginFormWireframeOutputContract
extension LoginFormPresenter: LoginFormWireframeOutputContract {
    
}
