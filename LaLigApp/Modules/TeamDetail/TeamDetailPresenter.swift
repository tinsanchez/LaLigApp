//
//  TeamDetailPresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 15/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class TeamDetailPresenter: BasePresenter, TeamDetailPresenterContract {

    weak var view: TeamDetailViewContract!
    var interactor: TeamDetailInteractorContract!
    var entity: TeamDetailEntityContract!
    var wireframe: TeamDetailWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {
        let teamData = interactor.getTeamData()
        view.reloadViewWithData(team: teamData)
    }
}

// MARK: - TeamDetailInteractorOutputContract
extension TeamDetailPresenter: TeamDetailInteractorOutputContract {
    
}

// MARK: - TeamDetailWireframeOutputContract
extension TeamDetailPresenter: TeamDetailWireframeOutputContract {
    
}
