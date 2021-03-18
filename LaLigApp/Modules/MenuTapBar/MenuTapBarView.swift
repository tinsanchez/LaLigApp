//
//  MenuTapBarView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 17/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MenuTapBarView: BaseTabBarController, MenuTapBarViewContract {

	var presenter: MenuTapBarPresenterContract?

	// MARK: - LifeCycle
    override func loadView() {
        MenuTapBarBuilder.setupPresenter(view: self)
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }

    private func setupView() {
        let views = presenter?.getTabBarViewController()
        
        self.viewControllers = views
        self.selectedIndex = 0
    }
}
