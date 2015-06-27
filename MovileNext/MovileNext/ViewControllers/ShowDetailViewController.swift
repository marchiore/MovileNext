//
//  ShowDetailViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailViewController: UIViewController {
    var show: Show!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.mostraOver{
            let vc = segue.destinationViewController as! OverviewViewController
            vc.show = show

        }else if segue == Segue.mostraSeason{
            let vc = segue.destinationViewController as! SeasonsTableViewController
            vc.show = show
            
        }else if segue == Segue.mostraGenres{
            let vc = segue.destinationViewController as! GenresViewController
            vc.show = show
            
        }else if segue == Segue.mostraDetail{
            let vc = segue.destinationViewController as! DetailViewController
            vc.show = show
            
        }
        
    }
    
}
