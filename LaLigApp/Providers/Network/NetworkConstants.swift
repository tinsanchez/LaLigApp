//
//  NetworkConstants.swift
//  LaLigApp
//
//  Created by Valentín Sánchez Campañón on 13/3/21.
//

import Foundation

let kAPIProdURL: String = "http://api.football-data.org/v2/competitions/PD/teams"
let kAPIDevURL: String = "http://api.football-data.org/v2/competitions/PD/teams"
let kApiProduction: Bool = Environment.appEnv == "Production"
let kAPIURL: String = kApiProduction ? kAPIProdURL : kAPIDevURL

let kLoginToken: String = "beca7ef6d2b84c339214dc43769cd1b0"
let kLoginHeader: String = "X-Auth-Token"

let kTimeoutIntervalForRequest = Double(10)
let kTimeoutIntervalForResource = Double(10)
