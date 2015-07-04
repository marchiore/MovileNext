//
//  FavoritesManager.swift
//  MovileNext
//
//  Created by User on 28/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Foundation

class FavoritesManager {

    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    var def = NSUserDefaults.standardUserDefaults()
    
    static let favoriteNotificationName = "favoriteChanged"

    var favoritesIdentifiers: Set<Int> {
        if let array = def.objectForKey("favorites") as? [Int]{
            return Set(array)
        }
        
        return Set<Int>()
    }

    func addIdentifier(identifier: Int){
        var identifiers = favoritesIdentifiers
        
        identifiers.insert(identifier)
        
        def.setObject([Int](identifiers), forKey: "favorites")
        def.synchronize()
    }

    func removeIdentifier(identifier: Int){
        var identifiers = favoritesIdentifiers
        
        identifiers.remove(identifier)
        
        def.setObject([Int](identifiers), forKey: "favorites")
        def.synchronize()

        
    }

    
}
