//
//  SeasonCell.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView

class SeasonCell: UITableViewCell {

    @IBOutlet weak var labelSeason: UILabel!
    @IBOutlet weak var imageSeason: UIImageView!
    @IBOutlet weak var labelNumOfEpisodes: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet var stars: FloatRatingView!
    
    func Negrito() -> Void{
        self.labelSeason.font = UIFont.boldSystemFontOfSize(17.0)
    }
    
    func Cinza() -> Void {
        labelNumOfEpisodes.textColor = UIColor.grayColor()
    }
    
    func loadSeason(season: Season) {
        let placeholder = UIImage(named: "poster")
        if let url = season.poster?.thumbImageURL {
            //imageSeason.hnk_setImageFromURL(url, placeholder: placeholder)
            imageSeason.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            imageSeason.image = placeholder
        }
    }
    func setRateStars(rate: Float) -> Void{
        stars.rating = rate
    }

    
    
}
