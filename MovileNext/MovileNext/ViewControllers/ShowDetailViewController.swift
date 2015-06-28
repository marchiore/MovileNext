//
//  ShowDetailViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView

class ShowDetailViewController: UIViewController, SeasonsTableViewControllerDelegate{
    var show: Show!
    
    //Constraints
    @IBOutlet var detailConst: NSLayoutConstraint!
    @IBOutlet var genresConst: NSLayoutConstraint!
    @IBOutlet var overviewConst: NSLayoutConstraint!
    @IBOutlet var seasonConst: NSLayoutConstraint!
    
    @IBOutlet var stars: FloatRatingView!
    @IBOutlet var rate: UILabel!
    @IBOutlet var imageShow: UIImageView!
    
    private weak var overviewViewController: OverviewViewController!
    private weak var seasonsTableViewController: SeasonsTableViewController!
    private weak var genresViewController: GenresViewController!
    private weak var detailViewController: DetailViewController!

    
    override func viewDidLoad() {
        self.title = show.title
        
        let placeholder = UIImage(named: "bg")
        if let url = show.thumbImageURL {
            imageShow.hnk_setImageFromURL(url, placeholder: placeholder)
        } else {
            imageShow.image = placeholder
        }
        
        if let rating = show?.rating{
            stars.rating = rating
            
            rate.text = NSString(format: "%.2f", rating) as String
        }

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.mostraOver{
            overviewViewController = segue.destinationViewController as! OverviewViewController
            self.overviewViewController.loadShows(show)
        }else if segue == Segue.mostraSeason{
            seasonsTableViewController = segue.destinationViewController as! SeasonsTableViewController
            self.seasonsTableViewController.loadSeason(show)
            
            //vc.show = show
        }else if segue == Segue.mostraGenre{
            self.genresViewController = segue.destinationViewController as! GenresViewController
            self.genresViewController.loadGenres(show)
            
        }else if segue == Segue.mostraDetails{
            self.detailViewController = segue.destinationViewController as! DetailViewController
            self.detailViewController.loadDetails(show)
        }
    }
    
    @IBAction func favorite(sender: AnyObject) {
        var favorite: FavoritesManager!
        
        favorite.addIdentifier(self.show.identifiers.trakt)
        
        favorite.removeIdentifier(self.show.identifiers.trakt)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        seasonConst.constant = seasonsTableViewController.intrinsicContentSize().height
        
        //Verificar como calcular a altura da UILabel
        overviewConst.constant = overviewViewController.intrinsicContentSize().height
        
        genresConst.constant = genresViewController.intrinsicContentSize().height
        
        
    }
    

    
    func seasonsController(vc: SeasonsTableViewController, didSelectSeason season: Season){
        println(season)
        
    }
    
}
