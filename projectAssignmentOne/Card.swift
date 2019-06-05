//
//  Card.swift
//  projectAssignmentOne
//
//  Created by Nikita Skrypchenko  on 11/25/18.
//  Copyright © 2018 Nikita Skrypchenko . All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var isFacedUp:Bool = false
    var isMatched:Bool = false
    private var id:Int
    
    
    static var idFactory = 0
    
    static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
}
