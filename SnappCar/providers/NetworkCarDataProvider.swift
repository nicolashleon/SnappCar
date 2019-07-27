//
//  NetworkCarDataProvider.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/25/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import RxAlamofire
import Alamofire
import RxSwift

class NetworkCarDataProvider: CarDataProvider {
        
    func searchCars(_ withCountry: String, _ sortingBy: String, _ ascendingResults: Bool, _ limitResultsTo: Int, _ offset: Int) -> Observable<Response<CarQueryResult>> {
        let carQueryUrl : String = Bundle.main.object(forInfoDictionaryKey: "URL_CAR_QUERY") as! String
        
        var order = "desc"
        if ascendingResults {
            order = "asc"
        }
        
        let parameters = ["country" : withCountry,
                          "sort" : sortingBy,
                          "order" : order,
                          "limit" : limitResultsTo,
                          "offset" : offset] as [String : Any]
        
        do {
            let url = try urlRequest(HTTPMethod.get, carQueryUrl, parameters: parameters, headers: nil)
            return request(url)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON()
                .map({ (dataResponse : DataResponse<Any>) -> Response<CarQueryResult> in
                    
                    guard let value = dataResponse.value else {
                        return Response(ProviderError.NetworkError(nil, "Data from the service is nil"))
                    }
                    
                    //TODO move json decoding to an extension or separate class to improve code maintainability
                    //and extensibility in the future.
                    do {
                        let carQueryResult = try JSONDecoder().decode(CarQueryResult.self, from: JSONSerialization.data(withJSONObject: value, options: []))
                        return Response(carQueryResult)
                        
                    } catch {
                        print("Error while decoding", error)
                        return Response(error)
                    }
                    
                })
        } catch {
            print("Error forming url to search cars ", error)
            return Observable.from(optional: Response(error))
        }
    }
}
