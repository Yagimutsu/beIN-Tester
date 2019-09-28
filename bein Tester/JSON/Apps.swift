//
//  Apps.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 10.07.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import Foundation

// MARK: - AppData
struct AppDatas: Codable {
    var apps: [App]
    
    init() { apps = [] }
    
    enum CodingKeys: String, CodingKey {
        case apps = "Apps"
    }
}

// MARK: - App
struct App: Codable {
    var appName: String
    var environments: [String]
    var availableCountries: [Country]?
    
    enum CodingKeys: String, CodingKey {
        case appName = "AppName"
        case environments = "Environments"
        case availableCountries = "AvailableCountries"
    }
}
