//
//  MenuTapBarPresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class MenuTapBarPresenter: BasePresenter, MenuTapBarPresenterContract {

    weak var view: MenuTapBarViewContract!
    var interactor: MenuTapBarInteractorContract!
    var entity: MenuTapBarEntityContract!
    var wireframe: MenuTapBarWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
    
    func getTabBarViewController() -> [BaseViewController] {
        let teamList = TeamListBuilder.build()
        let loginFormView = LoginFormBuilder.build()
        
        return [teamList, loginFormView]
    }
}

// MARK: - MenuTapBarInteractorOutputContract
extension MenuTapBarPresenter: MenuTapBarInteractorOutputContract {
    
}

// MARK: - MenuTapBarWireframeOutputContract
extension MenuTapBarPresenter: MenuTapBarWireframeOutputContract {
    
}
