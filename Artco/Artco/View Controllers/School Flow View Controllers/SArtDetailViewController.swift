//
//  ArtDetailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import CoreData

class SArtDetailViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties and outlets
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Listing> = {
        let fetchRequest: NSFetchRequest<Listing> = Listing.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "artistName", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    var indexPath: IndexPath?
    
    var listing: Listing? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try? fetchedResultsController.performFetch()
        } catch {
            NSLog("this ihit doesn't work")
        }
        
        setNewListingObject(indexPath)
        updateViews()
    }
    
    // MARK: Methods and functions
    
    public func convertDataToImage(_ data: Data) -> UIImage {
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
    func updateViews() {
        guard isViewLoaded,
            let listing = listing else { return }
        
        artImageView.image = convertDataToImage(listing.images ?? Data())
        artistNameLabel.text = listing.artistName
        titleLabel.text = listing.title
        priceLabel.text = listing.price.currencyOutputFormatting()
        categoryLabel.text = "\(listing.category)"
        descriptionTextView.text = listing.artDescription
    }
    
    @discardableResult private func setNewListingObject(_ with: IndexPath?) -> Listing? {
        guard let indexPath = indexPath else { return nil }
        listing = fetchedResultsController.object(at: indexPath)
        return listing
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editListingVC = segue.destination as? SEditArtViewController else { return }
        if segue.identifier == "EditArtListingSegue" {
            guard let listing = listing else { return }
            editListingVC.listing = listing
        }
    }
    
    
}


