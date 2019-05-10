//
//  TripModel.swift
//  TripXperience
//
//  Created by Sergio Llopis on 5/8/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import Foundation

class TripModel {
    
    var title: String?
    var description: String?
    var image : String?
    var profile : String?
    
    
    init(title: String?, description: String?){
        self.title = title
        self.description = description
    }
    
    init(title: String?, description: String?, image: String?){
        self.title = title
        self.description = description
        self.image = image
    }
    
    
    init(title: String?, image: String?){
        self.title = title
        self.image = image
    }
    
    init(profile: String?){
        self.profile = profile
        
    }
}
