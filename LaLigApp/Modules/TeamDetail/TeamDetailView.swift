//
//  TeamDetailView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 15/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TeamDetailView: BaseViewController, TeamDetailViewContract {

	var presenter: TeamDetailPresenterContract!
    
    @IBOutlet weak var teamImageView: UIView!
    @IBOutlet weak var detailtableView: UITableView!
    @IBOutlet weak var detailTabBar: UITabBar!
    
    var datasource: TeamDetailDataSource!
    // swiftlint:disable:next weak_delegate
    var delegate: TeamDetailDelegate!

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

    private func setupView() {
        detailtableView.register(UINib(nibName: DetailTableViewCell.cellId, bundle: nil),
                                 forCellReuseIdentifier: DetailTableViewCell.cellId)
        datasource = TeamDetailDataSource()
        delegate = TeamDetailDelegate()
        detailtableView.dataSource = datasource
        detailtableView.delegate = delegate
    }
    
    func reloadViewWithData(team: Team) {
        if let url = URL(string: team.imageThumb) {
            _ = UIView(SVGURL: url) { svglayer in
                svglayer.resizeToFit(self.teamImageView.bounds)
                self.teamImageView.layer.addSublayer(svglayer)
            }
        }
        datasource.teamData = genericData(team: team)
        detailtableView.reloadData()
    }
    
    private func genericData(team: Team) -> [(key: String, value: String)] {
        
        var teamData: [String: String] = [:]
        
        teamData["Shortname:"] = team.shortName
        teamData["Founded:"] = "\(team.founded)"
        teamData["Venue:"] = team.venue
        teamData["Clubcolors:"] = team.clubColors
        teamData["Website:"] = team.website
        // MARK: Implementado "sorted" para devolverlo ordenado en la misma posisión siempre.
        let teamDataSorted = teamData.sorted(by: { $0.key < $1.key })
       
        return teamDataSorted
    }

}

class TeamDetailDataSource: NSObject, UITableViewDataSource {
    
    var teamData: [(key: String, value: String)]!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.cellId,
                                                 // swiftlint:disable:next force_cast
                                                 for: indexPath) as! DetailTableViewCell

        cell.setData(title: teamData[indexPath.item].key,
                     value: teamData[indexPath.item].value)

        return cell
    }

}

class TeamDetailDelegate: NSObject, UITableViewDelegate {

}
