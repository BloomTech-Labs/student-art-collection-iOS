//
//  AddArtViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class AddArtViewController: UIViewController {
    
    // MARK: - Outlets and properties
    
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var suggestedDonationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let listingController = ListingController.shared
    let imagePickerController = UIImagePickerController()
    var imageStrings: [String] = []
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        suggestedDonationTextField.addTarget(self, action: #selector (textFieldDidChangeSelection(_:)), for: .editingDidBegin)
        suggestedDonationTextField.delegate = self
        descriptionTextView.delegate = self
    }
    
    // MARK: - Actions and methods
    
    @IBAction func addImages(_ sender: UITapGestureRecognizer) {
        checkPhotoPermission()
    }
    
    
    @IBAction func addArtButtonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            let artistName = studentNameTextField.text,
            !artistName.isEmpty,
            let categoryText = categoryTextField.text,
            !categoryText.isEmpty,
            let category = ListingCategory(rawValue: Float(categoryText)!),
            var suggestedDonation = suggestedDonationTextField.text,
            !suggestedDonation.isEmpty,
            let artDescription = descriptionTextView.text,
            !artDescription.isEmpty,
            !imageStrings.isEmpty else {
                presentAlert()
                return
        }
        
        if suggestedDonation.contains("$") {
            suggestedDonation.removeAll { $0 == "$" }
        }
        
        guard let price = Float(suggestedDonation) else { return }
        let images = imageStrings
        
        listingController.createListing(title: title, price: price, category: category, artistName: artistName, artDescription: artDescription, images: [""])
        
        // TODO: - Add fun animation when transitioning to gallery
        
        tabBarController?.selectedIndex = 0
        
    }
    
    
    
    private func presentAlert() {
        let missingValueAlert = UIAlertController(title: "Hold up!", message: "All fields must be filled out before a new art listing can be added.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        missingValueAlert.addAction(cancelAction)
        present(missingValueAlert, animated: true, completion: nil)
    }
    
}

extension AddArtViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // TODO: - Implement alerts for different authorization statuses
    // TODO: - Allow camera access via permission check and transition to separate view controller
    
    func checkPhotoPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            presentImagePicker()
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    self.presentImagePicker()
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        @unknown default:
            print("An unknown error occurred.")
        }
    }
    
    // TODO: - Move logic from background to serial queue for improved speed?
    
    func presentImagePicker() {
        let alert = UIAlertController(title: "Please select a photo source", message: nil, preferredStyle: .actionSheet)
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
                self.imagePickerController.sourceType = .photoLibrary
                DispatchQueue.main.async {
                    self.present(self.imagePickerController, animated: true, completion: nil)
                }
            }
            alert.addAction(photoLibraryAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let imageString = image.toString() else { return }
        imageStrings.append(imageString)
        DispatchQueue.main.async {
            self.topLeftImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension AddArtViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "$0.00"
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let priceString = textField.text?.currencyInputFormatting() {
            textField.text = priceString
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
