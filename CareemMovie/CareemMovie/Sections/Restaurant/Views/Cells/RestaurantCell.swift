//
//  RestaurantCell.swift
//  ListingRestaurant
//
//  Created by Canh Tran on 2/27/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import Kingfisher

class RestaurantCell: UITableViewCell {
    
    static let reuseIdentifier = "RestaurantCell"
    @IBOutlet weak var subContentView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantOpenTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.subContentView.layer.cornerRadius = 8
        self.contentView.layer.applySketchShadow(color: UIColor.black,
                                                 alpha: 0.4, x: 0, y: 3, blur: 3, spread: 0)
        restaurantImageView.layer.cornerRadius = 8
        restaurantImageView.layer.masksToBounds = false
    }
    
    func setupCellWithModel(model: Restaurant, index: Int) {
        restaurantNameLabel.text = model.name
        restaurantAddressLabel.text = model.address
        restaurantOpenTimeLabel.text = model.openinghours
        
        if let url = URL(string: model.imageurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            restaurantImageView.kf.setImage(with: url,
                                            placeholder: nil,
                                            options: [.transition(ImageTransition.fade(0.2))],
                                            progressBlock: { receivedSize, totalSize in
                                                print("\(index + 1): \(receivedSize)/\(totalSize)")
            },
                                            completionHandler: { image, error, cacheType, imageURL in
                                                print("\(index + 1): Finished")
            })
        }
        
    }
    
}
