//
//  Languages.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 10.07.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import Foundation

// MARK: - Language
struct Language: Codable {
    var locale, appLanguageCode, code, name: String
    
    enum CodingKeys: String, CodingKey {
        case locale = "Locale"
        case appLanguageCode = "AppLanguageCode"
        case code = "Code"
        case name = "Name"
    }
}

