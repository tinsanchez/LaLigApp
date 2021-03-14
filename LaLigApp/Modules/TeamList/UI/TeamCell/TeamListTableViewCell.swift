//
//  TeamCellView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import UIKit
import SDWebImage

class TeamListTableViewCell: UITableViewCell {
    
    static let cellId = "TeamListTableViewCell"
    
    @IBOutlet weak var teamThumb: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(team: Team) {
        if let url = URL(string: team.imageThumb) {
            teamThumb.sd_setImage(with: url, completed: nil)
        }
        teamLabel.text = team.name
    }
}
