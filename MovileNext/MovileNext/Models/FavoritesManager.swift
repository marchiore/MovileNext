//
//  FavoritesManager.swift
//  MovileNext
//
//  Created by User on 28/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Foundation

class FavoritesManager {

    var def = NSUserDefaults.standardUserDefaults()
    
    var favoritesIdentifiers: Set<Int>{
        return def.objectForKey("favorites") as! Set<Int>
    }

    func addIdentifier(identifier: Int){
        
        //favoritesIdentifiers.insert(identifier)
        
        def.setObject(favoritesIdentifiers, forKey: "favorites")
    }
    
    func removeIdentifier(identifier: Int){
    
    }
    
}
