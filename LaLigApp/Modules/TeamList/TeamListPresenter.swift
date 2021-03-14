//
//  TeamListPresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 12/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class TeamListPresenter: BasePresenter, TeamListPresenterContract {
    
    weak var view: TeamListViewContract!
    var interactor: TeamListInteractorContract!
    var entity: TeamListEntityContract?
    var wireframe: TeamListWireframeContract?
    
    var teamsList: [Team] = []

    func viewDidLoad() {

    }

    func viewWillAppear() {
        firstly {
            interactor.getTeamsList()
        }.done { [weak self] teamsListData in
            self?.teamsList = teamsListData
            self?.view.updateTeamData(teams: teamsListData)
        }.catch { error in
            self.view.feedbackError(error: error)
        }
    }
    
    func selectTeamCell(index: Int) {
        if teamsList.count > index {
            let team = teamsList[index]
            // TODO: descomentar una vez creada la lista detalle
            // wireframe.showDetailTeamView(team: team)
        } else {
          debugPrint("Object at index \(index) not found")
        }
    }
}

// MARK: - TeamListInteractorOutputContract
extension TeamListPresenter: TeamListInteractorOutputContract {
    
}

// MARK: - TeamListWireframeOutputContract
extension TeamListPresenter: TeamListWireframeOutputContract {
    
}
