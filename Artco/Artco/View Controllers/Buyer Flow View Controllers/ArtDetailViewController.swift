//
//  ArtDetailViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import Apollo

class ArtDetailViewController: UIViewController {

    // MARK: Properties & Outlets
    
    var id: String?
    var listing: ArtQuery.Data.Art? {
        didSet {
            updateViews()
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        
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
                case .failure:
                    print("You suck this didn't work you dumb bitch")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
