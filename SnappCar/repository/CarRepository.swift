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
    
    func searchCars(_ withCountry: Country, _ sortingBy: Sorting, _ ascendingResults: Bool, _ limitResultsTo: Int, _ offset: Int) -> Observable<CarItem> {
        
        return networkProvider.searchCars(withCountry.abbreviation(), sortingBy.rawValue, ascendingResults, limitResultsTo, offset).map { (result : CarQueryResult) -> [Result] in
                guard let results = result.results else {
                    return [Result]()
                }
                return results
            }
            .flatMap { (results : [Result]) -> Observable<Result> in
                return Observable.from(results)
            }
            .map { (result : Result) -> CarItem in
                return result.toCarItem()
            }
    }
}
