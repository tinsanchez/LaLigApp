//
//  LoginFormBuilder.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class LoginFormBuilder {

    static func build() -> LoginFormView {
        let view = LoginFormView.init(nibName: String(describing: LoginFormView.self), bundle: nil)
        
        view.tabBarItem = UITabBarItem(title: "Login".localizedString(), image: UIImage(systemName: "note.text"), tag: 0)
        
        let presenter = LoginFormPresenter()
        let entity = LoginFormEntity()
        let wireframe = LoginFormWireframe()
        
        let provider = AuthFirebaseNetworkProvider()
        let interactor = LoginFormInteractor(loginProvider: provider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe.output = presenter
        view.presenter.wireframe.view = view
        
        return view
    }
}
