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
import Apollo
import Cloudinary
import DropDown

enum Category: String, CaseIterable {
    case photograpy = "1"
    case drawing = "2"
    case painting = "3"
    case scultpure = "4"
    case other = "5"
}

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
    
    let cloudinary = Cloudinary.shared
    let imagePickerController = UIImagePickerController()
    var imageData: Data?
    var imageURL: String?
    let categoryDropDown = DropDown()
    var newListing: Listing?
    private let imageUploadQueue = OperationQueue()
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        keyboardDismiss()
        DropDown.startListeningToKeyboard()
        titleTextField.delegate = self
        studentNameTextField.delegate = self
        categoryTextField.delegate = self
        suggestedDonationTextField.delegate = self
        descriptionTextView.delegate = self
        suggestedDonationTextField.addTarget(self, action: #selector (textFieldDidChangeSelection(_:)), for: .editingDidBegin)
        initializeDropDown()
    }
    
    // MARK: - Actions
    
    @IBAction func addImages(_ sender: UITapGestureRecognizer) {
        checkPhotoPermission()
    }
    
    
    @IBAction func addArtButtonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            let artistName = studentNameTextField.text,
            !artistName.isEmpty,
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
        
        guard let price = Float(suggestedDonation),
            let images = imageData else { return }
        
        ListingController.shared.createListing(title: title, price: price, category: "1", artistName: artistName, artDescription: artDescription, images: images)
        
        guard let serverId = SchoolServerID.shared.serverId,
            let imageURL = imageURL else { return }
        
        Network.shared.apollo.perform(mutation: AddArtMutation(category: "1", school_id: serverId, price: Int(price), title: title, artist_name: artistName, description: artDescription, image_url: imageURL), context: nil, queue: DispatchQueue.main) { result in
            
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
                let message = graphQLError.localizedDescription
                self.showErrorAlert(title: "GraphQL Error", message: message)
            }
        }
        
        tabBarController?.selectedIndex = 0
        
        resetViews()
    }
    
    // MARK: - Functions
    
    // Shows drop down options in category selection
    private func initializeDropDown() {
        categoryDropDown.anchorView = categoryTextField.rightView
        categoryTextField.rightViewMode = .always
        categoryDropDown.direction = .bottom
        categoryDropDown.dismissMode = .onTap
        categoryDropDown.dataSource = ["Photography", "Drawing", "Painting", "Sculpture", "Other"]
        categoryTextField.addTarget(self, action:#selector(dropDown), for: .allEditingEvents)
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextField.text = item
        }
    }
    
    @objc func dropDown() {
        categoryDropDown.show()
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

// MARK: - Image picker delegate methods

extension SAddArtViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func checkPhotoPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            presentImagePicker()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self.presentImagePicker()
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
    
    // See UploadImageOperation.swift for information about image upload to Cloudinary. This function will capture the imageURL returned from Cloudinary for use in the addArt mutation to create listings on the server.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageData = image.pngData()
        
        let uploadImageOp = UploadImageOperation(image: image)
        
        let completionOp = BlockOperation {
            if let result = uploadImageOp.imageURL {
                self.imageURL = result
                print(self.imageURL as Any)
                DispatchQueue.main.async {
                    self.topLeftImageView.image = image
                    self.imagePickerController.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        completionOp.addDependency(uploadImageOp)
        imageUploadQueue.addOperation(uploadImageOp)
        OperationQueue.main.addOperation(completionOp)
    }
}

// MARK: Text field delegate methods

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

