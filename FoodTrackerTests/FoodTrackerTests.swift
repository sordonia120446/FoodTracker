//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Samuel Ordonia on 1/10/17.
//  Copyright © 2017 Samuel Ordonia. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests.  These are all run behind-the-scenes by default.
    
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSucceeds() {
        // zero & highest rating tests
        
        // zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // highest rating
        let epicMeal = Meal.init(name: "Epic", photo: nil, rating: 5)
        XCTAssertNotNil(epicMeal)
    } // end test method
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitFails() {
        // negative rating & empty string
        
        // negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // empty string
        let imaginaryMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(imaginaryMeal)
        
        // rating exceeds maximum
        let tooAwesomeMeal = Meal.init(name: "Too Awesome", photo: nil, rating: 6)
        XCTAssertNil(tooAwesomeMeal)
    }
    
}
