//
//  TeamListBuilder.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 12/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TeamListBuilder {

    static func build() -> TeamListView {
        let view = TeamListView.init(nibName: String(describing: TeamListView.self), bundle: nil)
        
        view.tabBarItem = UITabBarItem(title: "Teams List", image: UIImage(systemName: "scroll"), tag: 0)
        
        let presenter = TeamListPresenter()
        let entity = TeamListEntity()
        let wireframe = TeamListWireframe()
        
        let provider = TeamNetworkProvider()
        let interactor = TeamListInteractor(teamProvider: provider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe?.output = presenter
        view.presenter.wireframe?.view = view
        
        return view
    }
}
