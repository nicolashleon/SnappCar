//
//  Extensions.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/27/19.
//  Copyright © 2019 CarShare. All rights reserved.
//
import UIKit
import AlamofireImage

extension UIImageView {
    func loadImageSafely(_ url : String?, _ placeholder : String) {
        
        let placeholder = UIImage(named: placeholder)
        guard let urlString = url else {
            self.image = placeholder
            return
        }
        
        guard let urlAddress = URL(string : urlString) else {
            self.image = placeholder
            return
        }
       
        self.af_setImage(withURL: urlAddress, placeholderImage: placeholder)
    }
}

extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}

extension UITableView {
    func setMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.blue
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension String {
    static func getLocalizedString(key : String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension Result {
    func toCarItem() -> CarItem {
        
        var location = ""
        if let street = self.user?.street {
            location = street + ", "
        }
        
        if let city = self.user?.city {
            location += city
        }
        
        var name = ""
        if let make = self.car?.make {
            name = make + " "
        }
        
        if let model = self.car?.model {
            name += model
        }
        
        var priceWithCurrency = ""
        
        if let price = self.priceInformation?.price {
            priceWithCurrency = String(price)  + " "
        }
        
        if let currencyCode = self.priceInformation?.isoCurrencyCode {
            priceWithCurrency += currencyCode.uppercased()
        }
        
        
        return CarItem(name,
                self.car?.images?.first,
                priceWithCurrency,
                self.car?.reviewAvg,
                self.car?.reviewCount ?? 0,
                self.car?.images?.first,
                location)
    }
}
