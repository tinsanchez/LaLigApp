//
//  MenuTapBarContract.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol MenuTapBarEntityContract: BaseEntity {
    
}

protocol MenuTapBarViewContract: BaseTabBarController {
    var presenter: MenuTapBarPresenterContract? { get set }
    
}

protocol MenuTapBarPresenterContract: BasePresenter {
    var view: MenuTapBarViewContract! { get set }
    var interactor: MenuTapBarInteractorContract! { get set }
    var entity: MenuTapBarEntityContract! { get set }
    var wireframe: MenuTapBarWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    
    func getTabBarViewController() -> [BaseViewController]
}

protocol MenuTapBarInteractorContract: BaseInteractor {
    var output: MenuTapBarInteractorOutputContract! {get set}
}

protocol MenuTapBarInteractorOutputContract: class {
    
}

protocol MenuTapBarWireframeContract: BaseWireframe {
    var output: MenuTapBarWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol MenuTapBarWireframeOutputContract: class {

}
