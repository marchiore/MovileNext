//
//  ShowsViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels
import Haneke

class ShowsViewController: UIViewController {

    private let teste = TraktHTTPClient()
    private let httpClient = TraktHTTPClient()
    
    private var shows: [Show]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let show: Show
        let episode: Episode
        
        teste.getShow("game-of-thrones") { result in
            println("Show -> \(result.value?.title)")
        }
        
        teste.getEpisode("game-of-thrones", season: 1, episodeNumber: 1) { result in
            println("Ep -> \(result.value?.overview)")
        }
        
        teste.getPopularShows(){ result in
            println("Popular -> \(result.value?.count)")
        }
        
        teste.getEpisodes("game-of-thrones", season: 1) { result in
            //println("Error -> \(result.error)")
            println("Episodes -> \(result.value?.count)")
        }
        
        teste.getSeasons("game-of-thrones") { result in
            println("Seasons -> \(result.value?.count)")
        }
        
        loadShows()

    }
    
    func loadShows(){
        httpClient.getPopularShows({[weak self] result in
            if let shows = result.value {
                println("Conseguiu")
                self?.shows = shows
                self?.collectionView.reloadData()
                
            }else{
                println(result.error)
            }
            
        })
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.CellCollection.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowCell
        cell.descricao.text = shows?[indexPath.row].title
        var show  = shows?[indexPath.row]
        cell.loadShow(show!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets{
/*
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space, bottom: flowLayout.sectionInset.bottom, right: space)
*/
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width) / itemSize)
        let usedSpace = itemSize * maxPerRow
        var additionalSpace = flowLayout.minimumInteritemSpacing * maxPerRow
        var sideSpace = floor(((collectionView.bounds.width - usedSpace) + additionalSpace) / (maxPerRow + 1))
        
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: sideSpace, bottom: flowLayout.sectionInset.bottom, right: sideSpace)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.mostraSeason{
            if let cell = sender as? UICollectionViewCell, indexPath = collectionView.indexPathForCell(cell){
                let vc = segue.destinationViewController as! EpisodiosTableViewController
                vc.show = shows?[indexPath.row]
            }
        }
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
