//
//  GenresViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TagListView
import TraktModels

class GenresViewController: UIViewController, ShowInternalViewController {

    var show: Show!
    
    @IBOutlet var label: UILabel!
    @IBOutlet var genres: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenres(show)
    }
    
    func intrinsicContentSize() -> CGSize {
        var size = CGSize(width: view.bounds.width, height: genres.intrinsicContentSize().height)
        size.height += genres.frame.minY
        size.height += (view.bounds.height - genres.frame.maxY)
        
        return size
        
    }
    
    func loadGenres(sw: Show) -> Void{
        if isViewLoaded(){
            show.genres?.map(genres.addTag)
            self.title = show.title
        }
        self.show = sw
    }
    
    
}
