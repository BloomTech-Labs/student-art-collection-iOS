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
    
    // MARK: - Outlets and properties
    
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var artDescriptionTextView: UITextView!
    @IBOutlet weak var topLeftImageView: UIImageView!
    
    var imageData: Data?
    let imagePickerController = UIImagePickerController()
    var listing: Listing? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // keyboardDismiss()
        priceTextField.addTarget(self, action: #selector (textFieldDidChangeSelection(_:)), for: .editingDidBegin)
        priceTextField.delegate = self
        artDescriptionTextView.delegate = self
    }
    
    // MARK: - Actions and functions
    
    // This method currently only updates listings locally. While the backend was undergoing changes, updateArt functionality was not possible. The mutation is staged but commented out until functional.
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let listing = listing,
            let title = titleTextField.text, !title.isEmpty,
            let artDescription = artDescriptionTextView.text, !artDescription.isEmpty,
            let artistName = artistNameTextField.text, !artistName.isEmpty,
            var priceText = priceTextField.text, !priceText.isEmpty else { return }
        
        if priceText.contains("$") {
            priceText.removeAll { $0 == "$" }
        }
        
        guard let price = Float(priceText),
            let currentListingImages = listing.images else { return }
        
        ListingController.shared.updateListing(id: listing.id, listing: listing, title: title, price: price, category: "1", artistName: artistName, artDescription: artDescription, images: imageData ?? currentListingImages)
        
//      Network.shared.apollo.perform(mutation: UpdateArtMutation(id: <#T##GraphQLID#>, price: <#T##Int?#>, title: <#T##String?#>, artist_name: <#T##String?#>, description: <#T##String?#>), context: <#T##UnsafeMutableRawPointer?#>, queue: <#T##DispatchQueue#>, resultHandler: <#T##((Result<GraphQLResult<GraphQLSelectionSet>, Error>) -> Void)?##((Result<GraphQLResult<GraphQLSelectionSet>, Error>) -> Void)?##(Result<GraphQLResult<GraphQLSelectionSet>, Error>) -> Void#>)
        navigationController?.popToRootViewController(animated: true)
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
        categoryTextField.text = "\(String(describing: listing.category))"
        artistNameTextField.text = artistName
        topLeftImageView.image = convertDataToImage(imageData)
    }
    
    public func convertDataToImage(_ data: Data) -> UIImage {
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}

// MARK: - Image picker delegate methods

extension SEditArtViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

// MARK: - Text field and view delegate methods

extension SEditArtViewController: UITextFieldDelegate, UITextViewDelegate {
    
    // Allows for dynamic user input when entering a price for correct currency formatting. See String+CurrencyFormatter.swift for additional information.
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

