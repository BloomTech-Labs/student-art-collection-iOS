//
//  ArtDetailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import Apollo

enum Category: GraphQLID {
    case category
}

class ArtDetailViewController: UIViewController {

    // MARK: Properties & Outlets
    
    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    let ui = UIController.shared
    var id: GraphQLID?
    var listing: ArtQuery.Data.Art? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListing()
        updateViews()
    }
    
    private func setupUI() {
        ui.configureButton(addToCartButton)
    }
    
    func updateViews() {
        setupUI()
        guard isViewLoaded,
            let listing = listing else { return }
        listingImageView.image = convertToUIImage((listing.images?[0]?.imageUrl)!)!
        artistNameLabel.text = listing.artistName
        titleLabel.text = listing.title
        priceLabel.text = "$\(String(describing: listing.price!)).00"
        descriptionTextView.text = listing.description
        categoryLabel.text = "Painting"
    }

    private func loadListing() {
        guard isViewLoaded,
        let id = id else { return }

        Network.shared.apollo
            .fetch(query: ArtQuery(id: id)) { [weak self] result in

                guard let self = self else {
                    return
                }

                defer {
                    self.updateViews()
                }

                switch result {
                case .success(let graphQLResult):
                    if let downloadedListing = graphQLResult.data?.art {
                        self.listing = downloadedListing
                    }

                    if let errors = graphQLResult.errors {
                      let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                      self.showErrorAlert(title: "GraphQL Error(s)",
                                          message: message)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
      let alert = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alert, animated: true)
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
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        guard let listing = listing else { return }
        BuyerController.shared.addToCart(listing)
        dismiss(animated: true, completion: nil)
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
