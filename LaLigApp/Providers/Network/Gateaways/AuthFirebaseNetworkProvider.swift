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
    func sendRegisterDataForAuth(email: String, password: String) -> Promise<Bool>
    func sendConfirmationEmail()
}

class AuthFirebaseNetworkProvider: AuthFirebaseNetworkProviderContract {
   
    func sendRegisterDataForAuth(email: String, password: String) -> Promise<Bool> {
        return Promise<Bool> { promise in
            var confirmed = false
            Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
                if error != nil {
                    // MARK: Implementar el manejo de los errores de firebase
                    // para dar feedback al usuario de cual ha sido el problema.
                    print(error!)
                } else {
                    confirmed = true
                }
                promise.fulfill(confirmed)
            }
        }
    }
    
    func sendConfirmationEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil {
                print(error!)
            }
        })
    }
}
