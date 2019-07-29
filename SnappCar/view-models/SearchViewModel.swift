//
//  SearchViewModel.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/26/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import RxSwift

class SearchViewModel {
    
    private static let TIMEOUT = Bundle.main.object(forInfoDictionaryKey: "TIMEOUT_SECONDS") as! Int
    private let carRepository : CarRepository = CarRepository()
    
    func searchCars(_ withCountry: Country, _ sortingBy: Sorting, _ ascendingResults: Bool, _ limitResultsTo: Int, _ offset: Int) -> Observable<CarItem> {
       
        return carRepository.searchCars(withCountry, sortingBy, ascendingResults, limitResultsTo, offset)
            .timeout(RxTimeInterval.seconds(SearchViewModel.TIMEOUT), scheduler: ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentMainScheduler.instance)
    }

    func searchCarsByPosition(_ lat : Double, _ lng : Double, _ sortingBy: Sorting, _ ascendingResults: Bool, _ limitResultsTo: Int, _ offset: Int) -> Observable<CarItem> {
        return Observable.empty()
    }
}
