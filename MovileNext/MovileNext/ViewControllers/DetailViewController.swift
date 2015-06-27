//
//  DetailViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class DetailViewController: UIViewController {

    var show: Show!
    
    @IBOutlet var labelCountry: UILabel!
    @IBOutlet var labelStartedIn: UILabel!
    @IBOutlet var labelAired: UILabel!
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var labelNetwork: UILabel!
    
    override func viewDidLoad() {
        self.title = show.title
        if let country = show.country{
            labelCountry.text = country.uppercaseString
        }
        
        if let started = show?.year{
            labelStartedIn.text = "\(started)"
        }
        
        if let aired = show?.airedEpisodes{
            labelAired.text = "\(aired)"
        }
        
        if let status = show.status?.rawValue{
            labelStatus.text = "\(status)"
        }
        
        if let network = show.network{
            labelNetwork.text = network
        }
    }
    
}
