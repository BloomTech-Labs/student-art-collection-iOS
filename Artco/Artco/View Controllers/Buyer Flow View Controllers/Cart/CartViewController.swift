//
//  CartViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var additionalDonationTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    let ui = UIController.shared
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        monitorTextField()
        additionalDonationTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        updateTotal()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        ui.configureButton(checkoutButton)
    }
    
    private func monitorTextField() {
        additionalDonationTextField.addTarget(self, action: #selector(calculateAdditionalDonation), for: .editingChanged)
    }
    
    @objc func calculateAdditionalDonation() {
        if let donation = additionalDonationTextField.text  {
            var additionalDontation = donation
            
            if additionalDontation.contains("$") {
                additionalDontation.removeAll { $0 == "$" }
            }
            var subTotal = 0
            
           _ = BuyerController.shared.cart.map {
                guard let price = $0.price else { return }
                subTotal += price
            }
            
            guard let additionalDonation = Int(additionalDontation) else {return}
            
            let total = subTotal + additionalDonation
            
            subtotalLabel.text = "$\(subTotal).00"
            totalLabel.text = "$\(total).00"
        }
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

// MARK: - Table view delegate and data source methods

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BuyerController.shared.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        let listing = BuyerController.shared.cart[indexPath.row]
        cell.artImageView.image = convertToUIImage((listing.images?[0]?.imageUrl)!)!
        cell.artistNameLabel.text = listing.artistName
        cell.priceTextField.text = "$\(listing.price!).00"
        cell.categoryLabel.text = "Painting"
        return cell
    }
}

// MARK: - Text field delegate methods

extension CartViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == additionalDonationTextField {
            if let additonalDonation = textField.text?.currencyInputFormatting() {
                textField.text = additonalDonation
            }
        }
    }
    
}
