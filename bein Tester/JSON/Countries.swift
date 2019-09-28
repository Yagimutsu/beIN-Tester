//
//  Countries.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 10.07.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import Foundation

// MARK: - AvailableCountry
struct Country: Codable {
    var name, code: String
    var languages: [Language]
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case code = "Code"
        case languages = "Languages"
    }
}
