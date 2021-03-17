//
//  TeamDetailInteractor.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 15/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class TeamDetailInteractor: BaseInteractor, TeamDetailInteractorContract {
    
    weak var output: TeamDetailInteractorOutputContract!

    var networkProvider: TeamNetworkProvider
    var team: Team
    
    init (provider: TeamNetworkProvider, team: Team) {
        self.networkProvider = provider
        self.team = team
    }
    
    func getTeamData() -> Team {
        return team
    }
}
