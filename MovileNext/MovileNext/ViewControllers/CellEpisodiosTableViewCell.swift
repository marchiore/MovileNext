//
//  CellEpisodiosTableViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class CellEpisodiosTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.textColor = UIColor.grayColor()
        //let font = UIFont(name: "Arial", size: 10)!
        self.textLabel?.font = self.textLabel?.font.fontWithSize(12)
        self.detailTextLabel?.font = self.textLabel?.font.fontWithSize(15)
        // Initialization code
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.mup_orangeColorSelection()
        self.selectedBackgroundView = bgColorView;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
