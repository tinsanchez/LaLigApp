//
//  TeamCellView.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import UIKit
import SwiftSVG

class TeamListTableViewCell: UITableViewCell {
    
    static let cellId = "TeamListTableViewCell"
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var cellImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(team: Team) {
        if let url = URL(string: team.imageThumb) {
            // MARK: Utilización del Framework SwiftSVG puesto que la url de donde rescato la imagen es formato SVG.
            _ = UIView(SVGURL: url) { svglayer in
                svglayer.resizeToFit(self.cellImageView.bounds)
                self.cellImageView.layer.addSublayer(svglayer)
            }
        }
        teamLabel.text = team.name
    }
    
    override func prepareForReuse() {
        cellImageView.layer.sublayers?.removeAll()
    }
}
