//
//  TeamDetailBuilder.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 15/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TeamDetailBuilder {

    static func build(team: Team) -> TeamDetailView {
        let view = TeamDetailView.init(nibName: String(describing: TeamDetailView.self), bundle: nil)
        let presenter = TeamDetailPresenter()
        let entity = TeamDetailEntity()
        let wireframe = TeamDetailWireframe()
        
        let provider = TeamNetworkProvider()
        let interactor = TeamDetailInteractor(provider: provider, team: team)
        
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
