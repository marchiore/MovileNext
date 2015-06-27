//
//  OverviewViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class OverviewViewController: UIViewController {
    var show: Show!


    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        textView.text = show.overview
        label.textColor = UIColor.mup_orangeColor()
        self.title = show.title
    }
    
    
}
