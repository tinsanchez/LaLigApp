//
//  AuthFirebaseProvider.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 19/3/21.
//

import Foundation
import PromiseKit
import Firebase

typealias LoginFormProviderContract = AuthFirebaseNetworkProviderContract

protocol AuthFirebaseNetworkProviderContract {
    func sendFormData(email: String, password: String) -> Promise<Void>
}

class AuthFirebaseNetworkProvider: AuthFirebaseNetworkProviderContract {
    func sendFormData(email: String, password: String) -> Promise<Void> {
        return Promise<Void> { promise in
            Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
                if error != nil {
                    print(error!)
                }
            }
            promise.fulfill(())
        }
    }
}
