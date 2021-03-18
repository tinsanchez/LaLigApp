//
//  MenuTapBarBuilder.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MenuTapBarBuilder {

    static func build() -> MenuTapBarView {
        let view = MenuTapBarView.init(nibName: String(describing: MenuTapBarView.self), bundle: nil)
        
        return view
    }
    
    static func setupPresenter(view: MenuTapBarViewContract) {
        let presenter = MenuTapBarPresenter()
        let entity = MenuTapBarEntity()
        let wireframe = MenuTapBarWireframe()
        
        let interactor = MenuTapBarInteractor()
        
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.entity = entity
        view.presenter?.interactor = interactor
        view.presenter?.interactor.output = presenter
        view.presenter?.wireframe = wireframe
        
        view.presenter?.wireframe.output = presenter
        view.presenter?.wireframe.view = view
    }
}
