//
//  TeamListContract.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 12/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol TeamListEntityContract: BaseEntity {
    
}

protocol TeamListViewContract: BaseViewController {
    var presenter: TeamListPresenterContract! { get set }
    
    func updateTeamData(teams: [Team])
    func feedbackError(error: Error)
}

protocol TeamListPresenterContract: BasePresenter {
    var view: TeamListViewContract! { get set }
    var interactor: TeamListInteractorContract! { get set }
    var entity: TeamListEntityContract? { get set }
    var wireframe: TeamListWireframeContract? { get set }

    func viewDidLoad()
    func viewWillAppear()
    
    func selectTeamCell(index: Int)
}

protocol TeamListInteractorContract: BaseInteractor {
    var output: TeamListInteractorOutputContract! {get set}
    
    func getTeamsList() -> Promise<[Team]>
}

protocol TeamListInteractorOutputContract: class {
    
}

protocol TeamListWireframeContract: BaseWireframe {
    var output: TeamListWireframeOutputContract? { get set }
    var view: UIViewController? { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
    
    // TODO: func showDetailTeamView(team: Team)
}

protocol TeamListWireframeOutputContract: class {

}
