//
//  Meal.swift
//  FoodTracker
//
//  Created by Samuel Ordonia on 1/10/17.
//  Copyright © 2017 Samuel Ordonia. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Init
    init?(name: String, photo: UIImage?, rating: Int) {
        if name.isEmpty || rating < 0 {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
