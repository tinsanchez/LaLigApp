//
//  Team.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import Foundation
import PromiseKit

struct Team {
    
    var imageThumb: String
    var name: String
    var fav: Bool = false
    var clubColors: String
    var shortName: String
    var website: String
    var venue: String
    var founded: Int
    var address: String

    init(teamDAO: TeamDAO) {
        name = teamDAO.name
        if !teamDAO.imagesURL.isEmpty {
            imageThumb = teamDAO.imagesURL
        } else {
            imageThumb = ""
        }
        clubColors = teamDAO.clubColors
        shortName = teamDAO.shortName
        website = teamDAO.website
        venue = teamDAO.venue
        founded = teamDAO.founded
        address = teamDAO.address
    }
}
