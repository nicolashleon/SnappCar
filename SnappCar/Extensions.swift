//
//  Extensions.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/27/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

extension Result {
    func toCarItem() -> CarItem {
        
        var location = ""
        if let street = self.user?.street {
            location = street + ", "
        }
        
        if let city = self.user?.city {
            location += city
        }
        
        var name = ""
        if let make = self.car?.make {
            name = make + " "
        }
        
        if let model = self.car?.model {
            name += model
        }
        
        var priceWithCurrency = ""
        
        if let price = self.priceInformation?.price {
            priceWithCurrency = String(price)  + " "
        }
        
        if let currencyCode = self.priceInformation?.isoCurrencyCode {
            priceWithCurrency += currencyCode.uppercased()
        }
        
        
        return CarItem(name,
                self.car?.images?.first,
                priceWithCurrency,
                self.car?.reviewAvg,
                self.car?.reviewCount ?? 0,
                self.car?.images?.first,
                location)
    }
}
