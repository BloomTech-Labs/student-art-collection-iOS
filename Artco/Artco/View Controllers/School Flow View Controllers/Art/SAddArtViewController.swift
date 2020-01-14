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
import FirebaseAuth
import Cloudinary

class SAddArtViewController: UIViewController {
    
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
    let cloudinary = Cloudinary.shared
    let imagePickerController = UIImagePickerController()
    var imageData: Data?
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        keyboardDismiss()
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
            topLeftImageView.image != nil else {
                DispatchQueue.main.async {
                    self.presentAlert()
                }
                return
        }
        
        if suggestedDonation.contains("$") {
            suggestedDonation.removeAll { $0 == "$" }
        }
        
        guard let price = Float(suggestedDonation) else { return }
        guard let images = imageData else { return }
        listingController.createListing(title: title, price: price, category: category, artistName: artistName, artDescription: artDescription, images: images)
        guard let serverId = SchoolServerID.shared.serverId else { return }
        let date = Date().fullDate
        
        Network.shared.apollo.perform(mutation: AddArtMutation(category: categoryText, school_id: serverId, price: Int(price), sold: false, title: title, artist_name: artistName, description: artDescription, date_posted: date), context: nil, queue: DispatchQueue.main) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let graphQLResult):
                if let errors = graphQLResult.errors {
                    let message = errors
                        .map { $0.localizedDescription }
                        .joined(separator: "\n")
                    self.showErrorAlert(title: "GraphQL Error(s)",
                                        message: message)
                }
            case .failure(let graphQLError):
                print(graphQLError)
            }
        }
        
        tabBarController?.selectedIndex = 0
        
        resetViews()
    }
    
    private func keyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    private func presentAlert() {
        let missingValueAlert = UIAlertController(title: "Hold up!", message: "All fields must be filled out before a new art listing can be added.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        missingValueAlert.addAction(cancelAction)
        present(missingValueAlert, animated: true, completion: nil)
    }
    
    private func convertImageToData(_ image: UIImage) -> Data {
        guard let data = image.pngData() else { fatalError() }
        return data
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func resetViews() {
        topLeftImageView.image = nil
        titleTextField.text = ""
        studentNameTextField.text = ""
        categoryTextField.text = ""
        suggestedDonationTextField.text = "$0.00"
        descriptionTextView.text = "Please add a short description here"
    }
    
}

extension SAddArtViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        guard let data = image.jpegData(compressionQuality: 1) else { fatalError() }
        imageData = data
        
        cloudinary.cloudinary.createUploader().upload(data: data, uploadPreset: "smasd6kx", params: nil, progress: nil) { (result, error) in
            if let error = error {
                print(error)
            }
        }
        DispatchQueue.main.async {
            self.topLeftImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SAddArtViewController: UITextFieldDelegate, UITextViewDelegate {
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == suggestedDonationTextField {
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
