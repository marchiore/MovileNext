//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by User on 13/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var labelEpisodio: UILabel!
    @IBOutlet weak var textEpisodio: UITextView!
    @IBOutlet weak var imageEpisodio: UIImageView!
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {

        let url = NSURL(string: "http://www.apple.com")!
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textEpisodio.textContainer.lineFragmentPadding = 0
        textEpisodio.textContainerInset = UIEdgeInsetsZero
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
