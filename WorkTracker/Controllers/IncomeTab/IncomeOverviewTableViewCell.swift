//
//  IncomeOverviewTableViewCell.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/19/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit

class IncomeOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10.0
        print(cardView.frame.height)
        let buttonBlur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffect.Style.light))
        buttonBlur.frame = cardView.bounds
        buttonBlur.layer.cornerRadius = 10.0
        buttonBlur.clipsToBounds = true
        cardView.insertSubview(buttonBlur, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
