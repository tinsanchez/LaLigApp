//
//  LoginFormInteractor.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class LoginFormInteractor: BaseInteractor, LoginFormInteractorContract {
    weak var output: LoginFormInteractorOutputContract!

    var provider: LoginFormProviderContract
    var presenter: LoginFormPresenterContract!
    
    required init (loginProvider: LoginFormProviderContract) {
        self.provider = loginProvider
    }
   
    func sendRegisterData(email: String, password: String) -> Promise<Bool> {
        return Promise<Bool> { promise in
            firstly {
                self.provider.sendRegisterDataForAuth(email: email, password: password)
            }.done { confirmed in
                if confirmed == true {
                    promise.fulfill(confirmed)
                }
            }.catch { error in
                print(error)
            }
        }
    }
    
    func sendConfirmationEmail() {
        self.provider.sendConfirmationEmail()
    }
}
