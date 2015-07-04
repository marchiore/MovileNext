//
//  EpisodiosTableViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class EpisodiosTableViewController: UIViewController {

    @IBOutlet weak var episodiosTableView: UITableView!
    private let httpClient = TraktHTTPClient()
    
    var show: Show!
    var season: Season!
    private var episodes: [Episode]?
    private weak var episodeViewController: EpisodeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodes(show, season: season)
        self.title = show.title
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadEpisodes(sw: Show, season: Season){
        if isViewLoaded(){
            self.title = "Season \(self.season.number)"
            httpClient.getEpisodes(sw.identifiers.slug!, season: season.number){[weak self] result in
                if let episodes = result.value {
                    println("Conseguiu")
                    self?.episodes = episodes
                    self?.episodiosTableView.reloadData()
                }else{
                    println(result.error)
                }
            }
        }
        self.show = sw
        self.season = season
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return episodes?.count ?? 0
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.cell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier,   forIndexPath: indexPath) as! UITableViewCell
        
        var episode = episodes?[indexPath.row]
        
        var seasonString = String(format: "%02d", season.number)
        var numberString = String(format: "%02d", episode!.number)
        
        cell.textLabel?.text = "S\(seasonString)E\(numberString)"
        cell.detailTextLabel?.text = episode?.title
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.EpisodeSegue{
            if let cell = sender as? UITableViewCell, indexPath = episodiosTableView.indexPathForSelectedRow(){
                let ep = episodes?[indexPath.row]
                self.episodeViewController = segue.destinationViewController as! EpisodeViewController
                self.episodeViewController.loadEpisode(ep!, season: season)
            }
        }
    }
}
