//
//  UserRedirectViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/8/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit
import Apollo

class UserRedirectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.shared.apollo.perform(mutation: AddArtMutation(category: "5", school_id: "27"))
    }
    
    @IBAction func buyerRedirectButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "BuyerFlow", bundle: nil)
            let buyerTabBarController = storyboard.instantiateViewController(withIdentifier: "BuyerTabBarController")
            buyerTabBarController.modalPresentationStyle = .fullScreen
            self.present(buyerTabBarController, animated: true, completion: nil)
        }
    }

}
