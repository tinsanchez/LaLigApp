//
//  TeamDAO.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import Foundation
import ObjectMapper

struct TeamDAO: ImmutableMappable {

    let id: Int
    let name: String
    let imagesURL: String
    let clubColors: String
    let shortName: String
    let website: String
    let venue: String
    let founded: Int

    init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        imagesURL = try map.value("crestUrl")
        clubColors = try map.value("clubColors")
        shortName = try map.value("shortName")
        website = try map.value("website")
        venue = try map.value("venue")
        founded = try map.value("founded")
    }

    func mapping(map: Map) {
        id   >>> map["id"]
        name >>> map["name"]
        imagesURL >>> map["crestUrl"]
        clubColors >>> map["clubColors"]
        shortName >>> map["shortName"]
        website >>> map["website"]
        venue >>> map["venue"]
        founded >>> map["founded"]
    }
}
