//
//  CellEntry.swift
//  MovileExercicio
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

class CellEntry: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    func Negrito(){
        self.title.font = UIFont.boldSystemFontOfSize(16.0)
    }
    
    func Normal(){
        self.title.font = UIFont.systemFontOfSize(17.0)
    }
    
    
    
}
