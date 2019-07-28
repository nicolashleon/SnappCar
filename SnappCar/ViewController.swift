//
//  ViewController.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/24/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import UIKit
import RxSwift

class ViewController : UIViewController {
    
    private let viewModel = SearchViewModel()
    private var disposable : Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO Add tableview delegates to populate the data
        viewModel.searchCars(.NETHERLANDS, .recommended, true, 10, 0)
            .subscribe(onNext: { (carItem : CarItem) in
                print(carItem)
            }, onError: { (error : Error) in
                print(error)
            }, onCompleted: {
                print("Completed!")
            })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposable?.dispose()
    }
}

