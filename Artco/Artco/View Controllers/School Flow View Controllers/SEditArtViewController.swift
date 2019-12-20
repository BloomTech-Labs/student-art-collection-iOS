//
//  SEditArtViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/20/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class SEditArtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var delegate: EditArtDelegate?
    var listing: Listing?
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let listing = listing else { return }
        artUpdated(listing)
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

extension SEditArtViewController: EditArtDelegate {
    
    func artUpdated(_ listing: Listing) -> Listing {
        
    }
    
}
