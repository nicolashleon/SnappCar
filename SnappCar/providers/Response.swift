//
//  Data.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/26/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

class Response<T> {
    let value : T?
    let error : Error?
    
    init(_ value : T) {
        self.value = value
        self.error = nil
    }
    
    init(_ error : Error) {
        self.value = nil
        self.error = error
    }
    
    func isSuccessful() -> Bool {
        return error != nil 
    }
}
