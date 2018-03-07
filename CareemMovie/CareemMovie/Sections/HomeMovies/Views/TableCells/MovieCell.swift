//
//  MovieCell.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit

final class MovieCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.applySketchShadow(color: UIColor.shadownColor(), alpha: 1, x: 0, y: 2, blur: 4, spread: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupMovieCellWithModel(model: Movie) {
        
    }
    
}
