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
    
    
    var rating = 0 // leave this one as internal access, for use outside RatingControl

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
        for _ in 0..<starCount {
            
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
    } // end setupButtons

} // end class
