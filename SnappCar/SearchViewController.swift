//
//  ViewController.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/24/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController : UIViewController {

    private static let RESULT_LIMIT = 10
    
    private let viewModel = SearchViewModel()
    private let carAdapter = CarItemAdapter()
    private var disposable : Disposable?
    private var refreshControl = UIRefreshControl()
    private var ascendingOrder : Bool = true
    
    @IBOutlet weak var countrySegmentedControl: UISegmentedControl!
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CarItemCell.NIB, bundle: nil), forCellReuseIdentifier: CarItemCell.REUSE_IDENTIFIER)
        tableView.delegate = carAdapter
        tableView.dataSource = carAdapter
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshCarList(_:)), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposable?.dispose()
    }
    
    //TODO simplify this logic and make it easier to include pagination for the query results.
    private func queryCars(_ forceRefresh : Bool = false) {
        
        if !self.refreshControl.isRefreshing && forceRefresh {
            refreshControl.beginRefreshingManually()
        }
        
        if forceRefresh {
            tableView.restore()
            carAdapter.clear()
            tableView.reloadData()
        }
        
        var offset = 0
        
        if !forceRefresh {
            offset += carAdapter.count() + 10
        }
        
        let sorting : Sorting = Sorting.allCases[sortingSegmentedControl.selectedSegmentIndex]
        
        disposable = getCarItemObservable(sorting, offset)
            .subscribe(onNext: { [unowned self] (carItem : CarItem) in
                self.addCar(carItem)
            }, onError: { [unowned self] (error : Error) in
                self.showError(error)
                self.finishRefreshControl()
            }, onCompleted: { [unowned self] in
                self.finishRefreshControl()
                if(self.carAdapter.isEmpty()) {
                    self.showEmptyState()
                }
            })
    }
    
    private func getCarItemObservable(_ sorting : Sorting, _ offset : Int) -> Observable<CarItem> {
        let index = countrySegmentedControl.selectedSegmentIndex
        if index < Country.allCases.count {
            return viewModel.searchCars(Country.allCases[index], sorting, ascendingOrder, SearchViewController.RESULT_LIMIT, offset)
        } else {
            //TODO update this code to handle location
            return viewModel.searchCarsByPosition(0, 0, sorting, ascendingOrder, SearchViewController.RESULT_LIMIT, offset)
        }
        
    }
    
    private func addCar(_ carItem : CarItem) {
        carAdapter.addCar(carItem)
        self.tableView.reloadData()
    }
    
    @objc private func refreshCarList(_ sender: Any) {
        self.queryCars(true)
    }
    
    private func showEmptyState() {
        tableView.setMessage(String.getLocalizedString(key: "txt_empty_car_query"))
    }
    
    private func showError(_ error : Error) {
        print(error)
        tableView.setMessage(String.getLocalizedString(key: "txt_error_car_query"))
    }
    
    private func finishRefreshControl() {
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func onSortingChanged(_ sender: UISegmentedControl) {
        queryCars(true)
    }
    
    @IBAction func onOrderChanged(_ sender: Any) {
        ascendingOrder = !ascendingOrder
        queryCars(true)
    }
    
    @IBAction func onCountryChanged(_ sender: UISegmentedControl) {
        queryCars(true)
    }
}