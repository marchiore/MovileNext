//
//  SeasonsTableViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class SeasonsTableViewController: UITableViewController {
    
    var show: Show!
    private var seasons: [Season]?
    private let httpClient = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSeason()
        self.title = show.title
    }
    
    func loadSeason(){
        println("SLUG -" + show.identifiers.slug!)
        httpClient.getSeasons(show.identifiers.slug!) {[weak self] result in
            if let se = result.value {
                println("Conseguiu Season")
                self?.seasons = se
                self!.tableView.reloadData()
            }else{
                println(result.error)
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.seasonCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SeasonCell

        //Atribuindo as Cores
        cell.Negrito()
        cell.Cinza()
        cell.rate.textColor = UIColor.mup_orangeColor()
        
        var season = seasons?[indexPath.row]
        cell.loadSeason(season!)
        
        if let numberOfEpisodes = season?.episodeCount?.description{
            cell.labelNumOfEpisodes.text = "\(numberOfEpisodes) episodes"
        }
        
        if let seasonNumber = season?.number.description{
            cell.labelSeason.text = "Season \(seasonNumber)"
        }
        if let rating = season?.rating{
            cell.setRateStars(rating)
            
            cell.rate.text = NSString(format: "%.2f", rating) as String
        }
        
        let placeholder = UIImage(named: "poster")
        cell.imageSeason.image = placeholder
        
        return cell

    }
    
}
