//
//  CarItemCell.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/28/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import UIKit
import Cosmos

class CarItemCell : UITableViewCell {
    
    public static let NIB = "CarItem"
    public static let REUSE_IDENTIFIER = "CAR_CELL_REUSE_IDENTIFIER"
    
    @IBOutlet weak var carImageView: UIImageView?
    
    @IBOutlet weak var ownerImageView: UIImageView?
    
    @IBOutlet weak var carLabel: UILabel?
    
    @IBOutlet weak var locationLabel: UILabel?
    
    @IBOutlet weak var ratingView: CosmosView?
    
    @IBOutlet weak var priceLabel: UILabel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

