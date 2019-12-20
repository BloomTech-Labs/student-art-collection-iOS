//
//  SEditArtViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/20/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import Photos

class SEditArtViewController: UIViewController {
    
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var artDescriptionTextView: UITextView!
    @IBOutlet weak var topLeftImageView: UIImageView!
    
    var imageData: Data?
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // keyboardDismiss()
        priceTextField.addTarget(self, action: #selector (textFieldDidChangeSelection(_:)), for: .editingDidBegin)
        priceTextField.delegate = self
        artDescriptionTextView.delegate = self
    }
    
    var listing: Listing? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let listing = listing,
            let title = titleTextField.text, !title.isEmpty,
            let categoryText = categoryTextField.text, !categoryText.isEmpty,
            let category = ListingCategory(rawValue: Float(categoryText)!),
            let artDescription = artDescriptionTextView.text, !artDescription.isEmpty,
            let artistName = artistNameTextField.text, !artistName.isEmpty,
            var priceText = priceTextField.text, !priceText.isEmpty else { return }
        
        if priceText.contains("$") {
            priceText.removeAll { $0 == "$" }
        }
        
        guard let price = Float(priceText),
        let images = imageData else { return }
        ListingController.shared.updateListing(listing: listing, title: title, price: price, category: category, artistName: artistName, artDescription: artDescription, images: images)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImages(_ sender: UITapGestureRecognizer) {
           checkPhotoPermission()
       }
    
    private func updateViews() {
        guard let listing = listing,
            let title = listing.title,
            let artDescription = listing.artDescription,
            let artistName = listing.artistName,
            let imageData = listing.images,
            isViewLoaded else { return }
        
        
        titleTextField.text = title
        artDescriptionTextView.text = artDescription
        priceTextField.text = listing.price.currencyOutputFormatting()
        categoryTextField.text = "\(listing.category)"
        artistNameTextField.text = artistName
        topLeftImageView.image = convertDataToImage(imageData)
    }
    
    public func convertDataToImage(_ data: Data) -> UIImage {
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}

extension SEditArtViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let data = image.pngData() else { fatalError() }
        imageData = data
        DispatchQueue.main.async {
            self.topLeftImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SEditArtViewController: UITextFieldDelegate, UITextViewDelegate {
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == priceTextField {
            if let priceString = textField.text?.currencyInputFormatting() {
                textField.text = priceString
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    
}
