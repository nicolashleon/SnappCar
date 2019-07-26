//
//  NetworkError.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/26/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

enum ProviderError : Error {
    case NetworkError(_ error : Error?, _ message : String?)
}
