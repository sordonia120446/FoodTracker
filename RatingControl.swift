//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Samuel Ordonia on 12/31/16.
//  Copyright © 2016 Samuel Ordonia. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    // Superclass UIStackView? has required implementing this init in all subclasses
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button action
    func ratingButtonTapped(button: UIButton) {
        print("button pressed \u{1F496}")
    }
    
    //MARK: Private methods
    private func setupButtons() {
        /* Create button
        
         1) Simple init with zero-size rectangle; ok to use with Auto-layout
         2) Override auto-layout constraints with custom ones
         3) Add the button to the stack view
         
        */
        let button = UIButton()
        button.backgroundColor = UIColor.purple
        
        // Add button size constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        /* Setup button action
         
         1) Set target to self
         2) Selector identifies the method, in this case, ratingButtonTapped(_:)
         3) Call UIControlEvent touchUpInside when button is pressed
         
        */
        button.addTarget(self, action:
            #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        // Add to stack
        addArrangedSubview(button)
    }

}
