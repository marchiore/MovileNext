//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by User on 13/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class EpisodeViewController: UIViewController {

    @IBOutlet weak var labelEpisodio: UILabel!
    @IBOutlet weak var textEpisodio: UITextView!
    @IBOutlet weak var imageEpisodio: UIImageView!

    var episode: Episode!
    var season: Season!
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {

        let url = NSURL(string: "http://www.apple.com")!
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func loadEpisode(ep: Episode, season: Season){
        if isViewLoaded(){
            self.episode? = ep
            self.season? = season
            let placeholder = UIImage(named: "bg")
            if let url = episode.screenshot?.thumbImageURL {
                imageEpisodio.kf_setImageWithURL(url, placeholderImage: placeholder)
            } else {
                imageEpisodio.image = placeholder
            }
            
            imageEpisodio.image = imageEpisodio.image?.darkenImage()
            textEpisodio.text = episode.overview
            
            textEpisodio.textContainer.lineFragmentPadding = 0
            textEpisodio.textContainerInset = UIEdgeInsetsZero
            var seasonString = String(format: "%02d", season.number)
            var numberString = String(format: "%02d", episode.number)
            self.title = "S\(seasonString)E\(numberString)"
            
            labelEpisodio.text = episode.title
        }
        self.season = season
        self.episode = ep
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisode(episode, season: season)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
