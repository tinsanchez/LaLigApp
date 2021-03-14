//
//  TeamListView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 12/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TeamListView: BaseViewController, TeamListViewContract {

	var presenter: TeamListPresenterContract!

    @IBOutlet weak var tableView: UITableView!
    
    var datasource: TeamListDataSource!
    
    // swiftlint:disable weak_delegate
    var delegate: TeamListDelegate!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    // MARK: - Public methods
    func updateTeamData(teams: [Team]) {
        datasource.teams = teams

        tableView.reloadData()
    }

    func feedbackError(error: Error) {
        assert(false, "not implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        tableView.register(UINib(nibName: TeamListTableViewCell.cellId, bundle: nil),
                           forCellReuseIdentifier: TeamListTableViewCell.cellId)
        
        // Setup datasource & delegate
        datasource = TeamListDataSource()
        delegate = TeamListDelegate()
        delegate.presenter = presenter
        
        tableView.dataSource = datasource
        tableView.delegate = delegate
    }
}

class TeamListDataSource: NSObject, UITableViewDataSource {
    
    var teams: [Team] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamListTableViewCell.cellId,
                                                 // swiftlint:disable:next force_cast
                                                 for: indexPath) as! TeamListTableViewCell
        
        cell.setUpData(team: teams[indexPath.item])
        return cell
    }
    
}

class TeamListDelegate: NSObject, UITableViewDelegate {
    
    weak var presenter: TeamListPresenterContract!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // presenter.selectTeamCell(index: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
