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

class GenresViewController: UIViewController {

    var show: Show!
    
    @IBOutlet var label: UILabel!
    @IBOutlet var genres: TagListView!
    
    override func viewDidLoad() {
        show.genres?.map(genres.addTag)
        self.title = show.title
    }
}
