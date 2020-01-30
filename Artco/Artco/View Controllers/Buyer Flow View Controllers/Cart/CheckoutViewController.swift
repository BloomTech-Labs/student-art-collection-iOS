//
//  CheckoutViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var artworkCollectionView: UICollectionView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var additionalDonationTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var submitInquiryButton: UIButton!
    
    let name = Notification.Name(rawValue: String.nameNotificationKey)
    let email = Notification.Name(rawValue: String.emailNotificationKey)
    let message = Notification.Name(rawValue: String.messageNotificationKey)
    let ui = UIController.shared
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = updateTotal()
    }
    
    // MARK: Functions and actions
    
    private func setupUI() {
        ui.configureButton(submitInquiryButton)
    }
    
    
    private func updateTotal() {
        
        var subTotal = 0
        
       _ = BuyerController.shared.cart.map {
            guard let price = $0.price else { return }
            subTotal += price
        }
        
        subtotalLabel.text = "$\(subTotal).00"
        totalLabel.text = "$\(subTotal).00"
        
    }
    
    private func createObservers() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name(String.nameNotificationKey), object: nil, queue: OperationQueue.main) { (notification) in
            guard let userInfo = notification.userInfo else {return}
            self.nameLabel.text = "\(userInfo["name"] ?? "Name")"
            self.nameButton.setBackgroundImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
            
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(String.emailNotificationKey), object: nil, queue: OperationQueue.main) { (notification) in
            guard let userInfo = notification.userInfo else {return}
            self.emailLabel.text = "\(userInfo["email"] ?? "Email")"
            self.emailButton.setBackgroundImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(String.messageNotificationKey), object: nil, queue: OperationQueue.main) { (notification) in
            self.messageLabel.text = "Message successfully added!"
            
            self.messageButton.setBackgroundImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        }
        
    }
    
    // This function is largely for aesthetic purposes. In later releases involving purchases, this is where redirect to a payment service like Stripe would occur
    @IBAction func submitInquiryButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Success", message: "You will receive an email confirming your order! Thank you!", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            BuyerController.shared.cart = []
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Collection view delegate and data source methods

extension CheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BuyerController.shared.cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutArtworkCell", for: indexPath) as? CheckoutArtworkCollectionViewCell else { return UICollectionViewCell() }
        
        let listing = BuyerController.shared.cart[indexPath.row]
        cell.checkoutArtworkImageView.image = convertToUIImage((listing.images?[0]?.imageUrl)!)!
        
        return cell
    }
    
    private func convertToUIImage(_ str: String) -> UIImage? {
        var imageData: Data?
        guard let url = URL(string: str) else { return UIImage() }
        do {
            let data = try? Data(contentsOf: url)
            imageData = data
        }
        return UIImage(data: imageData ?? Data())
    }
}
