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

    let kAPIResultsKey = "results"
    let kAPIUrlKey = "url"

    func getTeams() -> Promise<[TeamDAO]> {
        var detailPagePromise: [Promise<TeamDAO>] = []

        return Promise<[TeamDAO]> { promise in

            self.getInitialPage().done { initialPage in
                for element in initialPage {
                    if let detailUrl = element[self.kAPIUrlKey] {
                        detailPagePromise.append(self.getTeamDetail(fullURLString: detailUrl))
                    }
                }

                when(resolved: detailPagePromise).done { results in
                    var fullfilledPromiseValues: [TeamDAO] = []
                    for case .fulfilled(let value) in results {
                        // These promises succeeded, and the values will be what is return from
                        // the last promises in chain1 and chain2
                        print("Promise value is: \(value)")
                        fullfilledPromiseValues.append(value)
                    }

                    debugPrint(results)

                    promise.fulfill(fullfilledPromiseValues)
                }.catch { error in
                    debugPrint(error)
                    // promise.reject(error)
                }
            }.catch { error in
                promise.reject(error)
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
    
    private func getInitialPage() -> Promise<[[String: String]]> {
        return Promise<[[String: String]]> { promise in
            let loginDictionary: HTTPHeaders = [kLoginHeader: kLoginToken]
            sessionManager.request(getUrl(service: .kInitialPage), headers: loginDictionary).responseJSON { response in
                guard let initialData = try? response.result.get() as? [String: Any],
                      let initialDataResults = initialData[self.kAPIResultsKey] as? [[String: String]] else {
                    promise.reject(TeamNetworkError.initialPageLoadError)
                    print(response)
                    return
                }
                print(initialDataResults)
                promise.fulfill(initialDataResults)
            }
            
           /* sessionManager.request(getUrl(service: .kInitialPage)).responseJSON { response in
                guard let initialData = try? response.result.get() as? [String: Any],
                      let initialDataResults = initialData[self.kAPIResultsKey] as? [[String: String]] else {
                    promise.reject(TeamNetworkError.initialPageLoadError)
                    print(promise)
                    return
                }
                
                promise.fulfill(initialDataResults)
            }*/
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
                    promise.fulfill(teamDAO)
                } else {
                    promise.reject(TeamNetworkError.detailPageLoadError)
                }
            }
        }
    }
}
