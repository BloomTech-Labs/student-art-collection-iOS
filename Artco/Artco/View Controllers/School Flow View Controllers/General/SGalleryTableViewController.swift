//
//  SchoolGalleryTableViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import CoreData

class SGalleryTableViewController: UITableViewController {

    lazy var fetchedResultsController: NSFetchedResultsController<Listing> = {
        let fetchRequest: NSFetchRequest<Listing> = Listing.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "artistName", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    

    
    static var schoolGalleryListings: [Listing] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         deleteObjectsIfSchoolAccountChanges("Listing")
        
        sleep(1)
        ListingController.shared.syncCoreData()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        ListingController.shared.syncCoreData()

    }
    
    private func deleteObjectsIfSchoolAccountChanges(_ entity: String) {
        
        let loggedInSchoolID = UserDefaults.standard.string(forKey: "loginID")
        
        let registerSchoolID = UserDefaults.standard.string(forKey: "schoolID")
        
        if loggedInSchoolID != registerSchoolID {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
              fetchRequest.returnsObjectsAsFaults = false
              do {
                let results = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
                  for object in results {
                      guard let objectData = object as? NSManagedObject else {continue}
                    CoreDataStack.shared.mainContext.delete(objectData)
                  }
              } catch let error {
                  print("Detele all data in \(entity) error :", error)
              }
        }
        
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as? SchoolGalleryTableViewCell else { return UITableViewCell() }
        let listing = fetchedResultsController.object(at: indexPath)
        cell.studentNameLabel.text = listing.artistName
        cell.priceLabel.text = listing.price.currencyOutputFormatting()
        cell.dateLabel.text = listing.datePosted
        let image = convertDataToImage(listing.images ?? Data())
        cell.galleryImageView.image = image
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listing = fetchedResultsController.object(at: indexPath)
            ListingController.shared.deleteListing(listing: listing)
        } else if editingStyle == .insert {
        }    
    }
 
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 
        return true
    }
    
    // MARK: - Methods and actions
    
    public func convertDataToImage(_ data: Data) -> UIImage {
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let listingDetailVC = segue.destination as? SArtDetailViewController else { return }
        if segue.identifier == "ArtDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let listing = fetchedResultsController.object(at: indexPath)
            listingDetailVC.listing = listing
        }
    }

}

extension SGalleryTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            return
        }
    }
    
}

