//
//  CovidData.swift
//  Final_PremSaiKrishna_Kandagattla
//
//  Created by user206624 on 8/16/22.
//

import Foundation


struct CovidData: Codable {
    let id, displayName: String
    let areas: [CovidData]
    let totalConfirmed: Int?
    let totalDeaths, totalRecovered, totalRecoveredDelta, totalDeathsDelta: Int?
    let totalConfirmedDelta: Int?
    let lastUpdated: String?
    let lat, long: Double?
    let parentID: String?

    enum CodingKeys: String, CodingKey {
        case id, displayName, areas, totalConfirmed, totalDeaths, totalRecovered, totalRecoveredDelta, totalDeathsDelta, totalConfirmedDelta, lastUpdated, lat, long
        case parentID = "parentId"
    }
}


