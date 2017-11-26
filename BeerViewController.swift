//
//  BeerViewController.swift
//  39951
//
//  Created by Rafael dos Santos Calderani on 25/11/17.
//  Copyright © 2017 Rafael dos Santos Calderani. All rights reserved.
//

import UIKit
import Kingfisher

class BeerViewController: UIViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbABV: UILabel!
    @IBOutlet weak var lbIBU: UILabel!
    @IBOutlet weak var ivBeer: UIImageView!
    
    var beer: Beer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showBeerValues()
    }
    
    func showBeerValues() {
        if beer != nil {
            
            let url = ImageResource(downloadURL: URL(string: (beer?.imageURL)!)!, cacheKey: beer?.name)
            let name = beer!.name
            let tagline = beer!.tagline
            let abv = beer!.alcoholByVolume
            let ibu = beer!.internationalBitternessUnits
            let description = beer!.description
            
            ivBeer.kf.setImage(with: url)
            lbName.text = name
            lbTagline.text = tagline
            lbABV.text = String(format: "%.1f", abv!)
            lbIBU.text = String(format: "%.1f", ibu!)
            
            lbDescription.text = description
            
        }
    
    }
}
