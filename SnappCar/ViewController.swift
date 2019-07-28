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
    private let carAdapter = CarItemAdapter()
    private var disposable : Disposable?
    
    private var refreshControl = UIRefreshControl()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CarItemCell.NIB, bundle: nil), forCellReuseIdentifier: CarItemCell.REUSE_IDENTIFIER)
        tableView.delegate = carAdapter
        tableView.dataSource = carAdapter
        tableView.addSubview(refreshControl)
        queryCars()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposable?.dispose()
    }
    
    private func queryCars() {
        disposable = viewModel.searchCars(.NETHERLANDS, .recommended, true, 10, 0)
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
    
    private func addCar(_ carItem : CarItem) {
        carAdapter.addCar(carItem)
        self.tableView.reloadData()
    }
    
    private func showEmptyState() {
        //tableView.setMessage(String.getLocalizedString(key: "txt_empty_item_add_rides"))
    }
    
    private func showError(_ error : Error) {
        print(error)
        //tableView.setMessage(String.getLocalizedString(key: "txt_error_item_ride_list"))
    }
    
    private func finishRefreshControl() {
        self.refreshControl.endRefreshing()
    }
    
    
    @IBAction func onSortingChanged(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func onOrderChanged(_ sender: Any) {
    
    }
    
}

