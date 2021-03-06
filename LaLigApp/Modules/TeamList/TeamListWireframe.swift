//
//  TeamListWireframe.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 12/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class TeamListWireframe: BaseWireframe, TeamListWireframeContract {
    
    weak var output: TeamListWireframeOutputContract?
    weak var view: UIViewController?

    weak var loadingDelegate: LoadingViewDelegate?

    /// Show basic loading
    /// - Parameters:
    ///   - text: text
    func showBasicLoading(text: String) {
        let loadingVC = LoadingViewController()
        self.loadingDelegate = loadingVC
        
        self.presentView(from: self.view, useCase: loadingVC, withTransition: .modal,
                         modalPresentationStyle: .overCurrentContext, animated: false, completion: {
            loadingVC.updateTitle(with: text)
        })
    }
    
    /// Hide basic loading
    func hideBasicLoading(completion: @escaping (() -> Void)) {
        self.loadingDelegate?.dismiss {
            completion()
        }
    }
    
    func showDetailTeamView(team: Team) {
        let detailModule = TeamDetailBuilder.build(team: team)
        self.presentView(from: self.view, useCase: detailModule,
                         withTransition: .modal, completion: nil)
    }
}
