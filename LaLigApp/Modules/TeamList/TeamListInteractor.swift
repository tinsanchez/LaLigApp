//
//  TeamListInteractor.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 12/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class TeamListInteractor: BaseInteractor, TeamListInteractorContract {
    
    weak var output: TeamListInteractorOutputContract!

    var teamProvider: TeamProviderContract
    
    init (teamProvider: TeamProviderContract) {
        self.teamProvider = teamProvider
    }
    
    func getTeamsList() -> Promise<[Team]> {
        return Promise<[Team]> { promise in
            firstly {
                self.teamProvider.getTeams()
            }.done { teamsDAOList in
                let teamsList = teamsDAOList.map { Team(teamDAO: $0)}
                promise.fulfill(teamsList)
            }
        }
    }
}
