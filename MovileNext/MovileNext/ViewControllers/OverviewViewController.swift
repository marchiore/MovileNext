//
//  OverviewViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class OverviewViewController: UIViewController, ShowInternalViewController {

    private var shw: Show!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadShows(shw)
    }
    
    func loadShows(show: Show) -> Void {
        if isViewLoaded() {
            self.textView.text = show.overview
            self.label.textColor = UIColor.mup_orangeColor()
            self.title = show.title
        }
        self.shw = show
    }
    

    func intrinsicContentSize() -> CGSize {
        /*
        println("Height -> \(textView.contentSize.height)")
        println("MinY -> \(textView.frame.minY)")
        println("bounds.height -> \(view.bounds.height)")
        println("textView.frame.maxY -> \(textView.frame.maxY)")
        */
        var size = CGSize(width: view.bounds.width, height: textView.contentSize.height)
        size.height += textView.frame.minY
        size.height += (view.bounds.height - textView.frame.maxY)
    
        return size

    }

}
