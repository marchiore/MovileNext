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
    private var episodes: [Episode]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadEpisodes(){
        httpClient.getEpisodes(show.identifiers.slug!, season: 1){[weak self] result in
            if let episodes = result.value {
                println("Conseguiu")
                self?.episodes = episodes
                self?.episodiosTableView.reloadData()
            }else{
                println(result.error)
            }
        }
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
        cell.textLabel?.text = episode?.number.description
        cell.detailTextLabel?.text = episode?.title
        
        return cell
    }
}
