//
//  ViewController.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/24/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController : UIViewController, UITableViewDataSourcePrefetching {

    private static let RESULT_LIMIT = 6
    private static let OFFSET = 10
    
    private let viewModel = SearchViewModel()
    private let carAdapter = CarItemAdapter()
    private var disposables = Array<Disposable>()
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
        tableView.prefetchDataSource = self
        refreshControl.addTarget(self, action: #selector(refreshCarList(_:)), for: .valueChanged)
        queryCars()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeAllObservables()
    }
    
    //TODO simplify this logic and make it easier to include pagination for the query results.
    private func queryCars() {
        
        
        if !self.refreshControl.isRefreshing {
            refreshControl.beginRefreshingManually()
        }
        
        let sorting : Sorting = Sorting.allCases[sortingSegmentedControl.selectedSegmentIndex]
        
        disposables.append(getCarItemObservable(sorting, carAdapter.count() + SearchViewController.OFFSET)
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
            }))
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
        let count = carAdapter.count()
        carAdapter.addCar(carItem)
        tableView.insertRows(at: [IndexPath(item: count, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    @objc private func refreshCarList(_ sender: Any) {
        clearAdapterAndTable()
        self.queryCars()
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
    
    private func clearAdapterAndTable() {
        tableView.restore()
        carAdapter.clear()
        tableView.reloadData()
    }
    
    @IBAction func onSortingChanged(_ sender: UISegmentedControl) {
        disposeAllObservables()
        clearAdapterAndTable()
        queryCars()
    }
    
    @IBAction func onOrderChanged(_ sender: Any) {
        disposeAllObservables()
        ascendingOrder = !ascendingOrder
        clearAdapterAndTable()
        queryCars()
    }
    
    @IBAction func onCountryChanged(_ sender: UISegmentedControl) {
        disposeAllObservables()
        clearAdapterAndTable()
        queryCars()
    }
    
    private func disposeAllObservables() {
        disposables.forEach { (disposable) in
            disposable.dispose()
        }
    }
    
    //TODO Improve the design for the prefetch mechanism to ensure a better compliance with the proposed
    //architecture
    //TODO Test more edge cases and ensure the solution's stability in particular when using multithreading
    //and different response times
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            if indexPath.item >= (carAdapter.count() - 1) {
                queryCars()
            }
        }
    }
    
}
