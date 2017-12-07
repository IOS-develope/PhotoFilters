//
//  ViewController.swift
//  PhotoFilters
//
//  Created by JerryYin on 06/12/2017.
//  Copyright © 2017 JerryYin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
    }
    
    //MARK: UITextFieldDelegate   --> override method to hadle user input
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
    //select image from library
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    //MARK: UIImagePickerControllerDelegate
    //called when user canceled iamge picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    // gets called when a user selects a photo.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?UIImage
    else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //set image view
        photoImageView.image = selectedImage
        //Dissmiss picker
        dismiss(animated: true, completion: nil)
    }
    
    

}

