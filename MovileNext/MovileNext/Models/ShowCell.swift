//
//  ShowCell.swift
//  MovileNext
//
//  Created by User on 21/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import Haneke
import TraktModels

class ShowCell: UICollectionViewCell {

    @IBOutlet weak var descricao: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    func loadShow(show: Show) {
        let placeholder = UIImage(named: "poster")
        if let url = show.poster?.fullImageURL {
            image.hnk_setImageFromURL(url, placeholder: placeholder)
        } else {
            image.image = placeholder
        }
        descricao.text = show.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        image.hnk_cancelSetImage()
        image.image = nil
    }

    
}
