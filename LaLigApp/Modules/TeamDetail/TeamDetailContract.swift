//
//  TeamDetailContract.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 15/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol TeamDetailEntityContract: BaseEntity {
    
}

protocol TeamDetailViewContract: BaseViewController {
    var presenter: TeamDetailPresenterContract! { get set }
    func reloadViewWithData(team: Team)
}

protocol TeamDetailPresenterContract: BasePresenter {
    var view: TeamDetailViewContract! { get set }
    var interactor: TeamDetailInteractorContract! { get set }
    var entity: TeamDetailEntityContract! { get set }
    var wireframe: TeamDetailWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    func openMapForPlace()
}

protocol TeamDetailInteractorContract: BaseInteractor {
    var output: TeamDetailInteractorOutputContract! {get set}
    func getTeamData() -> Team
}

protocol TeamDetailInteractorOutputContract: class {
    
}

protocol TeamDetailWireframeContract: BaseWireframe {
    var output: TeamDetailWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
    func openMapForPlace(latTeam: Double, longTeam: Double)
}

protocol TeamDetailWireframeOutputContract: class {

}
