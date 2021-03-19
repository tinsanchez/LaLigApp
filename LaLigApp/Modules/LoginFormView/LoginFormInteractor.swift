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
    
    required init (loginProvider: LoginFormProviderContract) {
        self.provider = loginProvider
    }
   
    func sendLoginData(email: String, password: String) -> Promise<Void> {
        return provider.sendFormData(email: email, password: password)
    }
}
