//
//  SuggestionCell.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit

final class SuggestionCell: UITableViewCell {
    
    @IBOutlet weak private var suggestionNameLabel: UILabel!
    @IBOutlet weak private var resultsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWithSuggestion(model: Suggestion) {
        suggestionNameLabel.text = model.name
        resultsLabel.text = model.totalResult
    }
    
}
