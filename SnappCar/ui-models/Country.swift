//
//  Country.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/25/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

enum Country : CaseIterable {
    
    case NETHERLANDS
    case DEUTSCHLAND
    case DENMARK
    case SWEDEN
    
    func abbreviation() -> String {
        switch self {
        case .NETHERLANDS: return "NL"
        case .DEUTSCHLAND: return "DE"
        case .DENMARK: return "DK"
        case .SWEDEN: return "SE"
        }
    }
}
