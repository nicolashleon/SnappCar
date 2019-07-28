//
//  CarItemAdapter.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/28/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import UIKit


class CarItemAdapter : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var data : Array<CarItem> = Array()
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarItemCell.REUSE_IDENTIFIER, for: indexPath) as! CarItemCell
        let carItem = data[indexPath.item]
        cell.carImageView?.loadImageSafely(carItem.carPictureUrl, "ic_car_placeholder")
        cell.ownerImageView?.loadImageSafely(carItem.userPictureUrl, "ic_user")
        cell.carLabel?.text = carItem.name
        cell.priceLabel?.text = carItem.price
        cell.locationLabel?.text = carItem.location
        
        cell.ratingView?.isHidden = false
        
        if let rating = carItem.rating {
            cell.ratingView?.rating = rating
            cell.ratingView?.text = "\((String(carItem.reviewCount)))"
        } else {
            cell.ratingView?.isHidden = true
        }
        
        return cell
    }
    
    
    public func addCar(_ carItem : CarItem) {
        data.append(carItem)
    }
    
    public func clear() {
        data.removeAll()
    }
    
    public func isEmpty() -> Bool {
        return data.count == 0
    }
}
