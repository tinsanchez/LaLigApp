//
//  Team.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import Foundation

struct Team {
    var imageThumb: String
    var name: String
    var fav: Bool = false
    var height: Double
    var weight: Double
    var types: [String]

    init(teamDAO: TeamDAO) {
        name = teamDAO.name
        if !teamDAO.imagesURL.isEmpty,
           let defaultFront = teamDAO.imagesURL[TeamDAO.defaultFront] as? String {
            imageThumb = defaultFront
        } else {
            imageThumb = ""
        }
        height = teamDAO.height
        weight = teamDAO.weight
        let typesString = teamDAO.types.map { element -> String? in
            if let type = element["type"] as? [String: String],
               let nameType = type["name"] {
                return nameType
            } else {
                return nil
            }
        }

        types = typesString.compactMap { $0 }
    }
}
