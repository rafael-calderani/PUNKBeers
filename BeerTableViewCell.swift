//
//  BeerTableViewCell.swift
//  39951
//
//  Created by Rafael dos Santos Calderani on 26/11/17.
//  Copyright © 2017 Rafael dos Santos Calderani. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbABV: UILabel!
    @IBOutlet weak var ivBeer: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
