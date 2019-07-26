//
//  CarRepository.swift
//  SnappCar
//
//  This class will handle multiple data providers and expose the data to the UI
//
//  Created by Nicolas Hurtado on 7/26/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import RxSwift

class CarRepository {
    private let networkProvider : CarDataProvider = NetworkCarDataProvider()
    
    func searchCars() {
        
        //TODO Call the network provider or database provider and return the data using the UI models instead of the data ones.
    }
}
