//
//  TeamsNetworkProviders.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import Foundation
import PromiseKit
import Alamofire

protocol TeamProviderContract {
    func getTeams() -> Promise<[TeamDAO]>
}

class TeamNetworkProvider: BaseNetworkProvider, TeamProviderContract {
    enum TeamURLEntries {
        case kInitialPage
        case kDetailTeam(String)
    }

    enum TeamNetworkError: Error {
        case initialPageLoadError, detailPageLoadError
    }

    let kAPIResultsKey = "teams"
    let kAPIUrlKey = "teams"

    func getTeams() -> Promise<[TeamDAO]> {
        
        var teamPromise: [TeamDAO] = []

        return Promise<[TeamDAO]> { promise in
            self.getInitialPage().done { initialPage in
                for element in initialPage {
                     print(element)
                    if let teamDAO = try? TeamDAO(JSON: element) {
                        // print(teamDAO)
                        teamPromise.append(teamDAO)
                    }
                }
                promise.fulfill(teamPromise)
            }
        }
    }

    private func getUrl(service: TeamURLEntries) -> URL {
        switch service {
        case .kInitialPage:
            return URL(string: "http://api.football-data.org/v2/competitions/PD/teams")!
        case .kDetailTeam(let teamId):
            return URL(string: "http://api.football-data.org/v2/competitions/2021/\(teamId)/")!
        }
    }
    
    private func getInitialPage() -> Promise<[[String: Any]]> {
        return Promise<[[String: Any]]> { promise in
            let loginDictionary: HTTPHeaders = [kLoginHeader: kLoginToken]
            sessionManager.request(getUrl(service: .kInitialPage), headers: loginDictionary).responseJSON { response in
                guard let initialData = try? response.result.get() as? [String: Any],
                      let initialDataResults = initialData[self.kAPIResultsKey] as? [[String: Any]] else {
                    promise.reject(TeamNetworkError.initialPageLoadError)
                    return
                }
                promise.fulfill(initialDataResults)
            }
        }
    }

    private func getTeamDetail(fullURLString: String) -> Promise<TeamDAO> {
        return Promise<TeamDAO> { promise in
            sessionManager.request(fullURLString).responseJSON { response in
                guard let detailPageData = try? response.result.get() as? [String: Any] else {
                    promise.reject(TeamNetworkError.detailPageLoadError)
                    return
                }

                if let teamDAO = try? TeamDAO(JSON: detailPageData) {
                   // print(teamDAO)
                    promise.fulfill(teamDAO)
                } else {
                    promise.reject(TeamNetworkError.detailPageLoadError)
                }
            }
        }
    }
}
