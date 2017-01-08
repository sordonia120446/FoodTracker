//
//  ViewController.swift
//  FoodTracker
//
//  Created by Samuel Ordonia on 12/30/16.
//  Copyright © 2016 Samuel Ordonia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    // Outlet vars for getting an interface object value OR modifying the interface object
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard upon hitting the return key on the keypad.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        /* Read the information entered into the text field and do something with it.
           Take the text that’s in the text field and use it to change the value of your label. */
        mealNameLabel.text = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /* 
        Use original represenation of the image in the info dictionary.
        
        This code safely unwraps the optional returned by the dictionary and casts it as a UIImage object. The expectation is that the unwrapping and casting operations will never fail. If they do, it represents either a bug in your app that needs to be fixed at design time. 
         
        The fatalError() method logs an error message to the console, including the contents of the info dictionary, and then causes the app to terminate—preventing it from continuing in an invalid state.
        */
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)

    }
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        // Sender is the button "Set default text label"
        mealNameLabel.text = "Meal Name"
//        mealNameLabel.text = nameTextField.text
    }
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard if the user had it up for some other use case.
        nameTextField.resignFirstResponder()
        
        // Pick media from photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allows images to be picked, not taken
        // Note:  UIImagePickerControllerSourceType is an enum
        imagePickerController.sourceType = .photoLibrary
        
        // Set the image picker controller delegate.  
        // Notify the ViewController when user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    



}




















