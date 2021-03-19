//
//  TeamDetailPresenter.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 15/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit
import CoreLocation

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
    
    func convertStringToLocation() {
        let team = interactor.getTeamData()
        self.coordinates(forAddress: team.address) { [self] (location) in
            guard let location = location else {
                    print("No ha sido posible hacer el casting de String a coordenadas")
                    return
            }
            self.wireframe.openMapForPlace(latTeam: location.latitude, longTeam: location.longitude, name: team.venue)
        }
    }
    
    private func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
}

// MARK: - TeamDetailInteractorOutputContract
extension TeamDetailPresenter: TeamDetailInteractorOutputContract {
    
}

// MARK: - TeamDetailWireframeOutputContract
extension TeamDetailPresenter: TeamDetailWireframeOutputContract {
    
}
