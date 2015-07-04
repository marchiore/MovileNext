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
    var season: Season!
    let fav = FavoritesManager()
    //Constraints
    @IBOutlet var detailConst: NSLayoutConstraint!
    @IBOutlet var genresConst: NSLayoutConstraint!
    @IBOutlet var overviewConst: NSLayoutConstraint!
    @IBOutlet var seasonConst: NSLayoutConstraint!
    
    @IBOutlet var stars: FloatRatingView!
    @IBOutlet var rate: UILabel!
    @IBOutlet var imageShow: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    private weak var overviewViewController: OverviewViewController!
    private weak var seasonsTableViewController: SeasonsTableViewController!
    private weak var genresViewController: GenresViewController!
    private weak var detailViewController: DetailViewController!
    private weak var episodiosViewController: EpisodiosTableViewController!
    
    let name = FavoritesManager.favoriteNotificationName
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    @IBAction func like(sender: UIButton) {
        let showId = show.identifiers.trakt
        if fav.favoritesIdentifiers.contains(showId){
            fav.removeIdentifier(showId)
        }else{
            fav.addIdentifier(showId)
        }
        controlaBtLike()
        
        notificationCenter.postNotificationName(name, object: self)
    }
    
    func controlaBtLike(){
        let showId = show.identifiers.trakt
        if fav.favoritesIdentifiers.contains(showId){
            likeButton.selected = true
        }else{
            likeButton.selected = false
        }
    }

    
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
        
        controlaBtLike()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == Segue.mostraOver{
            overviewViewController = segue.destinationViewController as! OverviewViewController
            self.overviewViewController.loadShows(show)
        }else if segue == Segue.mostraSeason{
            seasonsTableViewController = segue.destinationViewController as! SeasonsTableViewController
            seasonsTableViewController.delegate = self
            self.seasonsTableViewController.loadSeason(show)
            
            //vc.show = show
        }else if segue == Segue.mostraGenre{
            self.genresViewController = segue.destinationViewController as! GenresViewController
            self.genresViewController.loadGenres(show)
            
        }else if segue == Segue.mostraDetails{
            self.detailViewController = segue.destinationViewController as! DetailViewController
            self.detailViewController.loadDetails(show)
            
        }else if segue == Segue.segueEpi{
            self.episodiosViewController = segue.destinationViewController as! EpisodiosTableViewController
            self.episodiosViewController.loadEpisodes(show, season:season)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        seasonConst.constant = seasonsTableViewController.intrinsicContentSize().height
        
        //Verificar como calcular a altura da UILabel
        overviewConst.constant = overviewViewController.intrinsicContentSize().height
        
        genresConst.constant = genresViewController.intrinsicContentSize().height
    }
    
    func seasonsController(vc: SeasonsTableViewController, didSelectSeason season: Season){
        //println("Teste")
        println(season)
        self.season = season
        self.performSegue(Segue.segueEpi, sender: self)
    }

}
