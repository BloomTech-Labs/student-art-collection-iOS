//
//  CartViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var additionalDonationTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    let ui = UIController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        updateTotal()
    }
    
    private func setupUI() {
         ui.configureButton(checkoutButton)
     }
     
    private func updateTotal() {
           
           var subTotal = 0
           
          BuyerController.shared.cart.map {
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
        } catch {
            fatalError("URL was not compatible.")
        }
        
        return UIImage(data: imageData ?? Data())
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BuyerController.shared.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        let listing = BuyerController.shared.cart[indexPath.row]
        cell.imageView?.image = convertToUIImage((listing.images?[0]?.imageUrl)!)!
        cell.textLabel?.text = listing.artistName
        cell.detailTextLabel?.text = "$\(listing.price).00"
        return cell
    }
    
    
}
