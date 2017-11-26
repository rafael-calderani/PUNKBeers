//
//  BeersTableViewController.swift
//  39951
//
//  Created by Rafael dos Santos Calderani on 25/11/17.
//  Copyright © 2017 Rafael dos Santos Calderani. All rights reserved.
//

import UIKit
import Kingfisher

class BeersTableViewController: UITableViewController {
    @IBOutlet weak var uvLoading: UIView!
    
    lazy var beerList = [Beer]()
    var beerSelected: Beer?

    override func viewDidLoad() {
        super.viewDidLoad()

        PunkAPI.getBeers { beerListResult in
            guard let beers = beerListResult else { return }
            DispatchQueue.main.async {
                self.beerList = beers
                self.tableView.reloadData()
                self.uvLoading.isHidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerId", for: indexPath) as! BeerTableViewCell

        let url = ImageResource(downloadURL: URL(string: beerList[indexPath.row].imageURL!)!, cacheKey: beerList[indexPath.row].name)
        let abv = String(format: "%.1f", beerList[indexPath.row].alcoholByVolume ?? 0.0)
        
        cell.ivBeer.kf.setImage(with: url)
        cell.lbName.text = beerList[indexPath.row].name
        cell.lbABV.text = "Teor alcoólico: \(abv)"
        
        return cell
    }

    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        beerSelected = beerList[indexPath.row]
        performSegue(withIdentifier: "cervejaCadastroSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cervejaCadastroSegue" {
            let beerVC = segue.destination as! BeerViewController
            beerVC.beer = self.beerSelected
        }
    }

}
