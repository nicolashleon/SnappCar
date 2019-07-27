//
//  DataRepository.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/24/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import RxSwift

protocol CarDataProvider {
    func searchCars(_ withCountry: String, _ sortingBy: String, _ ascendingResults: Bool, _ limitResultsTo: Int, _ offset: Int) -> Observable<Response<CarQueryResult>>
}
