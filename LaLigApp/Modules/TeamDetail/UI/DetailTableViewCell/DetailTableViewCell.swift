//
//  DetailTableViewCell.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 16/3/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let cellId = "DetailTableViewCell"
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(title: String, value: String) {
        tittleLabel.text = title
        descriptionLabel.text = value
    }
}
