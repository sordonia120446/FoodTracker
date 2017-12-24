//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Samuel Ordonia on 12/31/16.
//  Copyright © 2016 Samuel Ordonia. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        // didSet property is called as soon as the value is set
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // leave this one as internal access, for use outside RatingControl
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    
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
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of:button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        if selectedRating == rating {
            // Reset current rating if user hits the same start again
            rating = 0
        } else {
            rating = selectedRating
        }
//        print("button pressed \u{1F496}")
    }
    
    //MARK: Private methods
    private func setupButtons() {
        /* Create button
        
         1) Clear any existing stars from before
         2) Simple init with zero-size rectangle; ok to use with Auto-layout
         3) Override auto-layout constraints with custom ones
         4) Add the buttons to the stack view
         
        */
        
        // Clear existing star buttons
        for button in ratingButtons {
            removeArrangedSubview(button) // remove from list of views managed by stack view
            button.removeFromSuperview() // remove from stack view entirely
        }
        
        ratingButtons.removeAll() // clear the entire array
        
        /* 
         Load in the button images from the assets catalog. 
         Explicitly specify the catalog's bundle to load properly in the Interface Builder.
        */
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle,
                                compatibleWith:self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle,
                                      compatibleWith: self.traitCollection)
        
        // Create the star buttons & add them to stack + ratingButtons[]
        for index in 0..<starCount {
            
            // Create a button
            let button = UIButton()
            
            /* 
             Set up button images. 
             
             Button states: normal, selected, highlighted, focused, & disabled
            */
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            
//             Deprecated color stuff from earlier
//            button.backgroundColor = UIColor.purple
            
            // Add button size constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set accessibility label
            button.accessibilityLabel = "Set \(index+1) star rating"
            
            /* Setup button action
             
             1) Set target to self
             2) Selector identifies the method, in this case, ratingButtonTapped(_:)
             3) Call UIControlEvent touchUpInside when button is pressed
             
             */
            button.addTarget(self, action:
                #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add to stack
            addArrangedSubview(button)
            
            // Add new button to rating button array
            ratingButtons.append(button)
        } // end for
        
        updateButtonSelectionStates()
    } // end setupButtons
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // Fill in all stars less than the current one
            button.isSelected = index < rating
            
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }
            
            // Calculate the value string.  Note that each case's value = rating
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            } // end switch-case 
            
            // Assign the hint & value strings
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
            
        }
    } // end updateButtonSelectionStates

} // end class
